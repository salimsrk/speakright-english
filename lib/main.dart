import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/module_select_screen.dart';

void main() {
  runApp(const SpeakRightApp());
}

class SpeakRightApp extends StatelessWidget {
  const SpeakRightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SpeakRight English",
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const ModuleSelectScreen(),
    );
  }
}
