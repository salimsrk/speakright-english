import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_tab_screen.dart';
import 'lessons_tab_screen.dart';
import 'progress_tab_screen.dart';
import 'settings_tab_screen.dart';

/// The app's top-level shell: a bottom navigation bar with four tabs
/// (Home, Lessons, Progress, Settings), matching the Home/Lessons/
/// Progress/Settings structure the client asked for — in our own existing
/// purple color scheme, not the reference screenshots' navy blue.
///
/// Each tab keeps its own state across switches (IndexedStack, not a
/// rebuilt route), and all of the actual module/topic navigation still
/// works exactly as it always did — it's reached by pushing a normal
/// route on top of this shell, from the Lessons tab.
class AppShellScreen extends StatefulWidget {
  const AppShellScreen({super.key});

  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  int _index = 0;

  void _goToLessons() => setState(() => _index = 1);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      HomeTabScreen(onStartLearning: _goToLessons),
      const LessonsTabScreen(),
      const ProgressTabScreen(),
      const SettingsTabScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: tabs),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: AppColors.primary.withOpacity(0.15),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: 11.5,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              color: selected ? AppColors.primaryDark : AppColors.inkSoft,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(color: selected ? AppColors.primary : AppColors.inkSoft);
          }),
        ),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          backgroundColor: AppColors.surface,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: "Lessons"),
            NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: "Progress"),
            NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
