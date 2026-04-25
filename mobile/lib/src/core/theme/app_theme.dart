import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFFFCF9F2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLow = Color(0xFFF6F3EC);
  static const Color surfaceVariant = Color(0xFFE5E2DB);
  static const Color outline = Color(0xFF747871);
  static const Color textPrimary = Color(0xFF1C1C18);
  static const Color textSecondary = Color(0xFF444842);
  static const Color primary = Color(0xFF50604D);
  static const Color primaryContainer = Color(0xFFD6E8CF);
  static const Color secondary = Color(0xFFFecd6F);
  static const Color tertiary = Color(0xFF69594D);
  static const Color error = Color(0xFFBA1A1A);

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: primary,
      onPrimary: Colors.white,
      secondary: tertiary,
      onSecondary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: surface,
      onSurface: textPrimary,
      outline: outline,
    );

    final base = ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: background,
    );

    return base.copyWith(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        base.textTheme,
      ).apply(bodyColor: textPrimary, displayColor: textPrimary),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),
      ),
      cardTheme: const CardThemeData(
        color: surface,
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          side: BorderSide(color: surfaceVariant),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: surfaceVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: surfaceVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        labelStyle: const TextStyle(color: textSecondary),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: const BorderSide(color: surfaceVariant),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: secondary,
        foregroundColor: textPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textPrimary,
        contentTextStyle: GoogleFonts.plusJakartaSans(color: Colors.white),
        behavior: SnackBarBehavior.floating,
      ),
      dividerTheme: const DividerThemeData(color: surfaceVariant),
    );
  }
}
