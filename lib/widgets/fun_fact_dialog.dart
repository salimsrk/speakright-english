import 'dart:math';
import 'package:flutter/material.dart';
import '../data/fun_fact_content.dart';
import '../models/fun_fact.dart';
import '../theme/app_theme.dart';

// A shuffled, non-repeating cycle through funFacts so a student doesn't see
// the same fact twice in a row across many exercises in one sitting. Kept
// as simple module-level state (not persisted) — it only needs to feel
// varied within a single session, not across app restarts.
final Random _funFactRandom = Random();
List<int> _funFactOrder = [];
int _funFactCursor = 0;

FunFact _nextFunFact() {
  if (_funFactOrder.isEmpty || _funFactCursor >= _funFactOrder.length) {
    _funFactOrder = List.generate(funFacts.length, (i) => i)..shuffle(_funFactRandom);
    _funFactCursor = 0;
  }
  final fact = funFacts[_funFactOrder[_funFactCursor]];
  _funFactCursor++;
  return fact;
}

/// Shows a light "Did you know?" popup after a student finishes an
/// exercise or topic, per the client's request that students get a small,
/// interesting break between drills so practice feels less repetitive.
///
/// This is purely a cosmetic extra layered on top of the existing lesson
/// flow — it is fail-soft by design (wrapped so it can never throw) and
/// callers don't need to await anything from it beyond letting the user
/// dismiss it; it never blocks or changes any scoring/navigation logic.
Future<void> showFunFact(BuildContext context) async {
  if (!context.mounted) return;
  try {
    final fact = _nextFunFact();
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(fact.emoji, style: const TextStyle(fontSize: 44)),
              const SizedBox(height: 10),
              const Text("Did you know?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
              const SizedBox(height: 12),
              Text(
                fact.fact,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14.5, height: 1.45, fontWeight: FontWeight.w600, color: AppColors.ink),
              ),
              if (fact.tamilFact.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    fact.tamilFact,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13.5, height: 1.4, color: AppColors.inkSoft, fontWeight: FontWeight.w500),
                  ),
                ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: FilledButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Text("Nice! Continue", style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } catch (_) {
    // A fun fact is a nice-to-have, never a blocker — if the dialog can't
    // show for any reason, just silently move on.
  }
}
