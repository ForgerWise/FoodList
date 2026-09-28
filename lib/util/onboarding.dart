import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import 'theme.dart';

/// One-time welcome card explaining the three gestures. Shown to new users
/// and once to existing users (tap-to-edit is new in this version).
Future<void> showOnboardingIfNeeded(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('onboarding_v1_shown') ?? false) return;
  if (!context.mounted) return;
  await showDialog(context: context, builder: (_) => const _OnboardingDialog());
  await prefs.setBool('onboarding_v1_shown', true);
}

class _OnboardingDialog extends StatelessWidget {
  const _OnboardingDialog();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Dialog(
      backgroundColor: context.c.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🥬', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            Text(
              s.onboardingTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: context.c.text,
              ),
            ),
            const SizedBox(height: 20),
            _step(context, Icons.add_rounded, s.onboardingAdd),
            _step(context, Icons.touch_app_outlined, s.onboardingTap),
            _step(context, Icons.swipe_left_outlined, s.onboardingSwipe),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(s.gotIt),
            ),
          ],
        ),
      ),
    );
  }

  Widget _step(BuildContext context, IconData icon, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 15, height: 1.4, color: context.c.text),
          ),
        ),
      ],
    ),
  );
}
