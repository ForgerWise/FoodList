import 'package:flutter/material.dart';

import '../database/languagedb.dart';
import '../generated/l10n.dart';
import '../setting/edit_categories.dart';
import '../setting/faq.dart';
import '../setting/feedback.dart';
import '../main.dart';
import '../setting/notification.dart';
import '../setting/policy.dart';
import '../setting/about.dart';
import '../util/app_scaffold.dart';
import '../util/notification.dart';
import '../util/app_settings.dart';
import '../util/review.dart';
import '../util/theme.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final NotificationService _notificationService = NotificationService();
  bool _notificationsEnabled = false;
  String _currentLanguage = '';

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    final enabled = await _notificationService.areNotificationsEnabled();
    final lang = await LanguageDB.getLanguage();
    if (mounted) {
      setState(() {
        _notificationsEnabled = enabled;
        _currentLanguage = lang;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text(S.of(context).settings)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // ── Section: Preferences ───────────────────────────────────────────
          _sectionLabel(context, S.of(context).preferences),
          _settingCard([
            _settingTile(
              context,
              icon: Icons.language,
              title: S.of(context).languages,
              subtitle: LanguageDB.languageNames[_currentLanguage] ?? '',
              onTap: () => _pick<String>(
                options: LanguageDB.languageNames.keys.toList(),
                current: _currentLanguage,
                label: (code) => LanguageDB.languageNames[code]!,
                onPicked: (code) async {
                  await LanguageDB.setLanguage(code);
                  if (!mounted) return;
                  MyApp.of(
                    this.context,
                  )?.setLocale(LanguageDB.languageToLocale(code));
                  _currentLanguage = code;
                },
              ),
            ),
            const _Separator(),
            _notificationTile(context),
            const _Separator(),
            _settingTile(
              context,
              icon: Icons.dark_mode_outlined,
              title: S.of(context).appearance,
              subtitle: _themeLabel(AppSettings.themeMode.value),
              onTap: () => _pick<ThemeMode>(
                options: ThemeMode.values,
                current: AppSettings.themeMode.value,
                label: _themeLabel,
                onPicked: AppSettings.setThemeMode,
              ),
            ),
            const _Separator(),
            _settingTile(
              context,
              icon: Icons.hourglass_bottom_rounded,
              title: S.of(context).soonThreshold,
              subtitle: S.of(context).soonThresholdValue(AppSettings.soonDays),
              onTap: () => _pick<int>(
                title: S.of(context).soonThresholdHint,
                options: AppSettings.soonDayOptions,
                current: AppSettings.soonDays,
                label: S.of(context).soonThresholdValue,
                onPicked: AppSettings.setSoonDays,
              ),
            ),
          ]),

          const SizedBox(height: 20),

          // ── Section: Ingredient Management ─────────────────────────────────
          _sectionLabel(context, S.of(context).ingredientManagement),
          _settingCard([
            _settingTile(
              context,
              icon: Icons.label_outline,
              title: S.of(context).editResetCategories,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditCategoriesPage()),
              ),
            ),
          ]),

          const SizedBox(height: 20),

          // ── Section: About ─────────────────────────────────────────────────
          _sectionLabel(context, S.of(context).about),
          _settingCard([
            _settingTile(
              context,
              icon: Icons.star_outline_rounded,
              title: S.of(context).rateApp,
              onTap: ReviewService.openStore,
            ),
            const _Separator(),
            _settingTile(
              context,
              icon: Icons.rate_review_outlined,
              title: S.of(context).feedback,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FeedbackPage()),
              ),
            ),
            const _Separator(),
            _settingTile(
              context,
              icon: Icons.help_outline,
              title: S.of(context).faq,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FAQPage()),
              ),
            ),
            const _Separator(),
            _settingTile(
              context,
              icon: Icons.privacy_tip_outlined,
              title: S.of(context).policy,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PolicyPage()),
              ),
            ),
            const _Separator(),
            _settingTile(
              context,
              icon: Icons.info_outline,
              title: S.of(context).about,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutPage()),
              ),
            ),
            const _Separator(),
            _settingTile(
              context,
              icon: Icons.description_outlined,
              title: S.of(context).license,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LicensePage()),
              ),
            ),
          ]),

          const SizedBox(height: 20),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ── Notification tile (shows current status, no switch) ──────────────────
  Widget _notificationTile(BuildContext context) {
    return _settingTile(
      context,
      icon: Icons.notifications_outlined,
      title: S.of(context).notifications,
      subtitle: _notificationsEnabled
          ? S.of(context).enabled
          : S.of(context).disabled,
      subtitleColor: _notificationsEnabled
          ? AppColors.fresh
          : context.c.textMuted,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const NotificationSettingPage()),
      ).then((_) => _loadStatus()),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _themeLabel(ThemeMode m) => switch (m) {
    ThemeMode.system => S.of(context).themeSystem,
    ThemeMode.light => S.of(context).themeLight,
    ThemeMode.dark => S.of(context).themeDark,
  };

  /// Bottom sheet with a single-choice list.
  Future<void> _pick<T>({
    String? title,
    required List<T> options,
    required T current,
    required String Function(T) label,
    required Future<void> Function(T) onPicked,
  }) async {
    final picked = await showModalBottomSheet<T>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                child: Text(title, style: TextStyle(color: ctx.c.textMuted)),
              ),
            for (final o in options)
              ListTile(
                title: Text(label(o)),
                trailing: o == current
                    ? const Icon(Icons.check_rounded, color: AppColors.primary)
                    : null,
                onTap: () => Navigator.pop(ctx, o),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (picked != null) {
      await onPicked(picked);
      if (mounted) setState(() {});
    }
  }

  Widget _sectionLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: context.c.textMuted,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _settingCard(List<Widget> children) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }

  Widget _settingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Color? subtitleColor,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              // Colored icon container (iOS style)
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 14),
              // Title + subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: context.c.text,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: subtitleColor ?? context.c.textMuted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 20, color: context.c.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 66),
      child: Divider(height: 1),
    );
  }
}
