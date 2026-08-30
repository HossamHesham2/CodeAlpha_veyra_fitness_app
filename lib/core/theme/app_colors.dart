import 'package:flutter/material.dart';

abstract final class AppColors {
  // ============================================================
  // Brand Colors
  // ============================================================

  static const Color primary = Color(0xFF7C4DFF);
  static const Color primaryDark = Color(0xFF673DE6);
  static const Color primaryLight = Color(0xFF9B7AFF);

  static const Color secondary = Color(0xFF00C9A7);
  static const Color secondaryDark = Color(0xFF00A98C);
  static const Color secondaryLight = Color(0xFF5DE1C9);

  static const Color tertiary = Color(0xFF2196F3);
  static const Color tertiaryDark = Color(0xFF1976D2);
  static const Color tertiaryLight = Color(0xFF64B5F6);

  // ============================================================
  // Accent Colors
  // ============================================================

  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFB300);
  static const Color error = Color(0xFFFF5252);
  static const Color info = Color(0xFF42A5F5);

  // ============================================================
  // Light Theme - Surfaces
  // ============================================================

  static const Color lightBackground = Color(0xFFF8F7FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainerLow = Color(0xFFF9F7FF);
  static const Color lightSurfaceContainer = Color(0xFFF2F0F8);
  static const Color lightSurfaceContainerHigh = Color(0xFFECEAF2);
  static const Color lightSurfaceContainerHighest = Color(0xFFE6E3EC);

  // ============================================================
  // Light Theme - Text
  // ============================================================

  static const Color lightOnBackground = Color(0xFF1A1720);
  static const Color lightOnSurface = Color(0xFF1A1720);
  static const Color lightOnSurfaceVariant = Color(0xFF625E69);

  // ============================================================
  // Light Theme - Borders
  // ============================================================

  static const Color lightOutline = Color(0xFF7A757F);
  static const Color lightOutlineVariant = Color(0xFFD0CBD5);

  // ============================================================
  // Dark Theme - Surfaces
  // ============================================================

  static const Color darkBackground = Color(0xFF080B16);
  static const Color darkSurface = Color(0xFF101522);
  static const Color darkSurfaceContainerLowest = Color(0xFF080B14);
  static const Color darkSurfaceContainerLow = Color(0xFF121827);
  static const Color darkSurfaceContainer = Color(0xFF171D2D);
  static const Color darkSurfaceContainerHigh = Color(0xFF202637);
  static const Color darkSurfaceContainerHighest = Color(0xFF2A3041);

  // ============================================================
  // Dark Theme - Text
  // ============================================================

  static const Color darkOnBackground = Color(0xFFE9E7F0);
  static const Color darkOnSurface = Color(0xFFE9E7F0);
  static const Color darkOnSurfaceVariant = Color(0xFFC5C0CC);

  // ============================================================
  // Dark Theme - Borders
  // ============================================================

  static const Color darkOutline = Color(0xFF918C98);
  static const Color darkOutlineVariant = Color(0xFF45414C);

  // ============================================================
  // ColorScheme - Light
  // ============================================================

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,

    // Primary
    primary: primary,
    primaryFixed: lightNavy,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFE9DDFF),
    onPrimaryContainer: Color(0xFF25005A),

    // Secondary
    secondary: secondary,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFB5F2E5),
    onSecondaryContainer: Color(0xFF00201A),

    // Tertiary
    tertiary: tertiary,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFD5E4FF),
    onTertiaryContainer: Color(0xFF001B3E),

    // Error
    error: error,
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    // Surfaces
    surface: lightSurface,
    onSurface: lightOnSurface,
    surfaceTint: primary,

    surfaceDim: Color(0xFFDEDCE3),
    surfaceBright: Color(0xFFFFFFFF),

    surfaceContainerLowest: lightSurfaceContainerLowest,
    surfaceContainerLow: lightSurfaceContainerLow,
    surfaceContainer: lightSurfaceContainer,
    surfaceContainerHigh: lightSurfaceContainerHigh,
    surfaceContainerHighest: lightSurfaceContainerHighest,

    // Variants
    onSurfaceVariant: lightOnSurfaceVariant,
    outline: lightOutline,
    outlineVariant: lightOutlineVariant,

    // Other
    shadow: Colors.black,
    scrim: Colors.black,

    inverseSurface: Color(0xFF302E35),
    onInverseSurface: Color(0xFFF2EFF7),
    inversePrimary: primaryLight,
  );

  // ============================================================
  // ColorScheme - Dark
  // ============================================================

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    // Primary
    primary: primaryLight,
    primaryFixed: darkNavy,
    onPrimary: Color(0xFF39008A),
    primaryContainer: Color(0xFF5B2DB8),
    onPrimaryContainer: Color(0xFFE9DDFF),

    // Secondary
    secondary: secondaryLight,
    onSecondary: Color(0xFF00382F),
    secondaryContainer: Color(0xFF005047),
    onSecondaryContainer: Color(0xFFB5F2E5),

    // Tertiary
    tertiary: tertiaryLight,
    onTertiary: Color(0xFF00315C),
    tertiaryContainer: Color(0xFF00497D),
    onTertiaryContainer: Color(0xFFD5E4FF),

    // Error
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),

    // Surfaces
    surface: darkSurface,
    onSurface: darkOnSurface,
    surfaceTint: primaryLight,

    surfaceDim: Color(0xFF0E111A),
    surfaceBright: Color(0xFF343944),

    surfaceContainerLowest: darkSurfaceContainerLowest,
    surfaceContainerLow: darkSurfaceContainerLow,
    surfaceContainer: darkSurfaceContainer,
    surfaceContainerHigh: darkSurfaceContainerHigh,
    surfaceContainerHighest: darkSurfaceContainerHighest,

    // Variants
    onSurfaceVariant: darkOnSurfaceVariant,
    outline: darkOutline,
    outlineVariant: darkOutlineVariant,

    // Other
    shadow: Colors.black,
    scrim: Colors.black,

    inverseSurface: Color(0xFFE4E1E9),
    onInverseSurface: Color(0xFF302E35),
    inversePrimary: primary,
  );

  // ============================================================
  // Fitness Specific Colors
  // ============================================================

  static const Color steps = Color(0xFF4CAF50);
  static const Color calories = Color(0xFFFF7043);
  static const Color workout = Color(0xFF7C4DFF);
  static const Color weight = Color(0xFF2196F3);
  static const Color heartRate = Color(0xFFFF5252);
  static const Color darkNavy = Color(0xFF151D2D);
  static const Color lightNavy = Color(0xFFF1F5F9);
}
