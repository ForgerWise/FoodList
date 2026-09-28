import 'package:flutter/material.dart';

/// Brand and status colours — identical in light and dark mode.
class AppColors {
  static const primary = Color(0xFF2F7D5B); // fresh leaf green
  static const expired = Color(0xFFD64545);
  static const soon = Color(0xFFE58A1F);
  static const fresh = Color(0xFF2F9E6A);
}

/// Colours that change with light/dark mode. Use via `context.c`.
/// `*Text` variants are for small text/icons on `surface` (WCAG ≥ 4.5:1);
/// the plain AppColors are for fills and large numbers.
class Palette {
  final Color background, surface, text, textMuted, border;
  final Color accent, expiredText, soonText, freshText;
  const Palette({
    required this.background,
    required this.surface,
    required this.text,
    required this.textMuted,
    required this.border,
    required this.accent,
    required this.expiredText,
    required this.soonText,
    required this.freshText,
  });
}

const _light = Palette(
  background: Color(0xFFF6F7F4),
  surface: Colors.white,
  text: Color(0xFF1C2420),
  textMuted: Color(0xFF626C66),
  border: Color(0xFFE4E8E3),
  accent: AppColors.primary,
  expiredText: Color(0xFFC0392B),
  soonText: Color(0xFFA35400),
  freshText: Color(0xFF23794F),
);
const _dark = Palette(
  background: Color(0xFF111513),
  surface: Color(0xFF1B211E),
  text: Color(0xFFE5EBE7),
  textMuted: Color(0xFF9AA59F),
  border: Color(0xFF2D3631),
  accent: Color(0xFF5CC394),
  expiredText: Color(0xFFFF8A80),
  soonText: Color(0xFFFFB45C),
  freshText: Color(0xFF6FD3A1),
);

extension PaletteX on BuildContext {
  Palette get c =>
      Theme.of(this).brightness == Brightness.dark ? _dark : _light;
}

ThemeData buildAppTheme(Brightness brightness) {
  final p = brightness == Brightness.dark ? _dark : _light;
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: brightness,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    surface: p.background,
    onSurface: p.text,
  );
  final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: p.background,
    appBarTheme: AppBarTheme(
      backgroundColor: p.background,
      foregroundColor: p.text,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: p.text,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardTheme: CardThemeData(
      color: p.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: p.border),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: shape,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: shape,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(shape: shape),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: p.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: TextStyle(color: p.textMuted),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: p.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: p.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: p.surface,
      selectedColor: AppColors.primary,
      side: BorderSide(color: p.border),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      labelStyle: TextStyle(fontSize: 14, color: p.text),
      secondaryLabelStyle: const TextStyle(fontSize: 14, color: Colors.white),
      showCheckmark: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: p.surface,
      indicatorColor: AppColors.primary.withValues(alpha: 0.14),
      surfaceTintColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    dividerTheme: DividerThemeData(color: p.border, space: 1),
  );
}
