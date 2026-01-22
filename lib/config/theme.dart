import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Daylight Theme Configuration
/// Premium color palette with vibrant accents for professional branding
class AppTheme {
  // ===========================
  // PRIMARY COLORS
  // ===========================
  static const Color primary50 = Color(0xFFEEF2FF);
  static const Color primary100 = Color(0xFFE0E7FF);
  static const Color primary200 = Color(0xFFC7D2FE);
  static const Color primary300 = Color(0xFFA5B4FC);
  static const Color primary400 = Color(0xFF818CF8);
  static const Color primary500 = Color(0xFF6366F1); // Main Primary
  static const Color primary600 = Color(0xFF4F46E5);
  static const Color primary700 = Color(0xFF4338CA);
  static const Color primary800 = Color(0xFF3730A3);
  static const Color primary900 = Color(0xFF312E81);

  // ===========================
  // SECONDARY COLORS (Purple)
  // ===========================
  static const Color secondary50 = Color(0xFFFAF5FF);
  static const Color secondary100 = Color(0xFFF3E8FF);
  static const Color secondary200 = Color(0xFFE9D5FF);
  static const Color secondary300 = Color(0xFFD8B4FE);
  static const Color secondary400 = Color(0xFFC084FC);
  static const Color secondary500 = Color(0xFFA855F7); // Main Secondary
  static const Color secondary600 = Color(0xFF9333EA);
  static const Color secondary700 = Color(0xFF7E22CE);
  static const Color secondary800 = Color(0xFF6B21A8);
  static const Color secondary900 = Color(0xFF581C87);

  // ===========================
  // ACCENT COLORS (Pink)
  // ===========================
  static const Color accent50 = Color(0xFFFDF2F8);
  static const Color accent100 = Color(0xFFFCE7F3);
  static const Color accent200 = Color(0xFFFBCFE8);
  static const Color accent300 = Color(0xFFF9A8D4);
  static const Color accent400 = Color(0xFFF472B6);
  static const Color accent500 = Color(0xFFEC4899); // Main Accent
  static const Color accent600 = Color(0xFFDB2777);
  static const Color accent700 = Color(0xFFBE185D);
  static const Color accent800 = Color(0xFF9D174D);
  static const Color accent900 = Color(0xFF831843);

  // ===========================
  // NEUTRAL COLORS
  // ===========================
  static const Color gray50 = Color(0xFFFAFAFA); // Background
  static const Color gray100 = Color(0xFFF5F5F5); // Surface Light
  static const Color gray200 = Color(0xFFE5E5E5); // Border Light
  static const Color gray300 = Color(0xFFD4D4D4);
  static const Color gray400 = Color(0xFFA3A3A3);
  static const Color gray500 = Color(0xFF737373); // Text Muted
  static const Color gray600 = Color(0xFF525252);
  static const Color gray700 = Color(0xFF404040);
  static const Color gray800 = Color(0xFF262626);
  static const Color gray900 = Color(0xFF171717); // Text Primary

  // ===========================
  // SEMANTIC COLORS
  // ===========================
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF059669);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFFD97706);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFDC2626);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  static const Color infoDark = Color(0xFF2563EB);

  // ===========================
  // GRADIENTS
  // ===========================
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary500, primary600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary500, secondary600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [primary500, secondary500],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [gray50, Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ===========================
  // SHADOWS
  // ===========================
  static List<BoxShadow> get shadowSm => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 3,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get shadowMd => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowLg => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get shadowXl => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.15),
      blurRadius: 60,
      offset: const Offset(0, 20),
    ),
  ];

  static List<BoxShadow> get shadowPrimary => [
    BoxShadow(
      color: primary500.withValues(alpha: 0.25),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowPrimaryLg => [
    BoxShadow(
      color: primary500.withValues(alpha: 0.35),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  // ===========================
  // THEME DATA
  // ===========================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: primary500,
        primaryContainer: primary100,
        secondary: secondary500,
        secondaryContainer: secondary100,
        tertiary: accent500,
        tertiaryContainer: accent100,
        error: error,
        errorContainer: errorLight,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        onError: Colors.white,
        onSurface: gray900,
      ),

      // Scaffold
      scaffoldBackgroundColor: gray50,

      // AppBar
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: gray900,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: gray900,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: gray200, width: 1),
        ),
        shadowColor: Colors.black.withValues(alpha: 0.05),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primary500,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary600,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          side: BorderSide(color: primary500, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: gray700,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: gray200, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: gray200, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary500, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: errorDark, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: gray700,
        ),
        hintStyle: GoogleFonts.inter(fontSize: 14, color: gray400),
      ),

      // Typography
      textTheme: TextTheme(
        // Display - Hero Headlines
        displayLarge: GoogleFonts.outfit(
          fontSize: 72,
          fontWeight: FontWeight.w700,
          height: 1.1,
          color: gray900,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          height: 1.2,
          color: gray900,
        ),
        displaySmall: GoogleFonts.outfit(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: gray900,
        ),

        // Headlines
        headlineLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: gray900,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: gray900,
        ),
        headlineSmall: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: gray900,
        ),

        // Titles
        titleLarge: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: gray900,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: gray900,
        ),
        titleSmall: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.4,
          color: gray900,
        ),

        // Body
        bodyLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          height: 1.7,
          color: gray900,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: gray900,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: gray600,
        ),

        // Labels
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.4,
          color: gray700,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.4,
          color: gray600,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          height: 1.4,
          color: gray500,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: gray600, size: 24),

      // Divider
      dividerTheme: DividerThemeData(color: gray200, thickness: 1, space: 32),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: primary400, // Lighter for dark mode
        primaryContainer: primary900,
        secondary: secondary400,
        secondaryContainer: secondary900,
        tertiary: accent400,
        tertiaryContainer: accent900,
        error: error,
        errorContainer: errorDark,
        surface: gray900,
        onPrimary: gray900,
        onSecondary: gray900,
        onTertiary: gray900,
        onError: Colors.white,
        onSurface: gray50,
      ),

      // Scaffold
      scaffoldBackgroundColor: const Color(0xFF020617), // Deep Navy Blue/Black
      // AppBar
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: const Color(0xFF020617),
        foregroundColor: Colors.white,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: 8,
        color: const Color(0xFF0F172A), // Slate 900 - Rich Deep Blue
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: const Color(0xFF1E293B),
            width: 1,
          ), // Slate 800 Border
        ),
        shadowColor: Colors.black.withValues(alpha: 0.5),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primary500,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary300,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          side: BorderSide(color: primary500, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: gray300,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF0F172A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: gray700, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: gray700, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary400, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: errorDark, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: gray300,
        ),
        hintStyle: GoogleFonts.inter(fontSize: 14, color: gray500),
      ),

      // Typography
      textTheme: TextTheme(
        // Display
        displayLarge: GoogleFonts.outfit(
          fontSize: 72,
          fontWeight: FontWeight.w700,
          height: 1.1,
          color: Colors.white,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          height: 1.2,
          color: Colors.white,
        ),
        displaySmall: GoogleFonts.outfit(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: Colors.white,
        ),

        // Headlines
        headlineLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: Colors.white,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.4,
          color: Colors.white,
        ),
        headlineSmall: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Colors.white,
        ),

        // Titles
        titleLarge: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Colors.white,
        ),
        titleSmall: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.4,
          color: gray300,
        ),

        // Body
        bodyLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          height: 1.7,
          color: gray100,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: gray200,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: gray400,
        ),

        // Labels
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.4,
          color: gray300,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.4,
          color: gray400,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          height: 1.4,
          color: gray500,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: gray300, size: 24),

      // Divider
      dividerTheme: DividerThemeData(color: gray800, thickness: 1, space: 32),
    );
  }

  // ===========================
  // SPACING UTILITIES
  // ===========================
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double space2xl = 48.0;
  static const double space3xl = 64.0;
  static const double space4xl = 96.0;

  // ===========================
  // BORDER RADIUS
  // ===========================
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radius2xl = 24.0;
  static const double radius3xl = 32.0;
  static const double radiusFull = 9999.0;
}
