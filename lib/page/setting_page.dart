import 'package:flutter/material.dart';

import '../database/languagedb.dart';
import '../generated/l10n.dart';
import '../setting/edit_categories.dart';
import '../setting/faq.dart';
import '../setting/feedback.dart';
import '../setting/language.dart';
import '../setting/notification.dart';
import '../setting/policy.dart';
import '../setting/about.dart';
import '../util/notification.dart';

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
    final lang = await LanguageDB.getLanguageWithoutContext();
    if (mounted) {
      setState(() {
        _notificationsEnabled = enabled;
        _currentLanguage = lang;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          S.of(context).settings,
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // ── Section: Preferences ───────────────────────────────────────────
          _sectionLabel(context, S.of(context).preferences),
          _settingCard([
            _settingTile(
              context,
              icon: Icons.language,
              iconBg: const Color(0xFF1E88E5),
              title: S.of(context).languages,
              subtitle: _langDisplayName(_currentLanguage),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LanguagePage()),
              ).then((_) => _loadStatus()),
            ),
            const _Separator(),
            _notificationTile(context),
          ]),

          const SizedBox(height: 20),

          // ── Section: Ingredient Management ─────────────────────────────────
          _sectionLabel(context, S.of(context).ingredientManagement),
          _settingCard([
            _settingTile(
              context,
              icon: Icons.label_outline,
              iconBg: const Color(0xFF43A047),
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
              icon: Icons.help_outline,
              iconBg: const Color(0xFF7B1FA2),
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
              iconBg: const Color(0xFF00897B),
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
              iconBg: const Color(0xFF546E7A),
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
              iconBg: const Color(0xFF757575),
              title: S.of(context).license,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LicensePage()),
              ),
            ),
          ]),

          const SizedBox(height: 100),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FeedbackPage()),
        ),
        label: Text(S.of(context).feedback,
            style: const TextStyle(color: Colors.white)),
        icon: const Icon(Icons.rate_review_outlined, color: Colors.white),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }

  // ── Notification tile (shows current status, no switch) ──────────────────
  Widget _notificationTile(BuildContext context) {
    return _settingTile(
      context,
      icon: Icons.notifications_outlined,
      iconBg: const Color(0xFFFFA000),
      title: S.of(context).notifications,
      subtitle: _notificationsEnabled ? S.of(context).enabled : S.of(context).disabled,
      subtitleColor: _notificationsEnabled
          ? const Color(0xFF43A047)
          : Colors.grey,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const NotificationSettingPage()),
      ).then((_) => _loadStatus()),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _sectionLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.blueGrey.shade600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _settingCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _settingTile(
    BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required String title,
    String? subtitle,
    Color? subtitleColor,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
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
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 14),
              // Title + subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF212121),
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: subtitleColor ?? Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  size: 20, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }

  String _langDisplayName(String code) {
    const names = {
      'en': 'English',
      'zh_TW': '繁體中文',
      'ja': '日本語',
    };
    return names[code] ?? code;
  }
}

class _Separator extends StatelessWidget {
  const _Separator();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 66),
      child: Divider(height: 0.5, color: Colors.grey.shade200),
    );
  }
}
