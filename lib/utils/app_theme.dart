import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // CGHEVEN Color Palette
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSecondary = Color(0xFF1E1E1E);
  static const Color textPrimary = Color(0xFFEAEAEA);
  static const Color textSecondary = Color(0xFFB0B0B0);

  // Fire/Explosion Gradient Colors
  static const Color fireStart = Color(0xFFFF6B00);
  static const Color fireEnd = Color(0xFFFF3C00);

  // Energy/Teal Gradient Colors
  static const Color tealStart = Color(0xFF00E5FF);
  static const Color tealEnd = Color(0xFF00B8D4);

  // Gradients
  static const LinearGradient fireGradient = LinearGradient(
    colors: [fireStart, fireEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient greyGradeubt = LinearGradient(
    colors: [AppTheme.darkBackground, Color(0xFF1A0F0D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient tealGradient = LinearGradient(
    colors: [tealStart, tealEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient logoGradient = LinearGradient(
    colors: [fireStart, tealStart],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [darkBackground, darkSecondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Theme Data
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: fireStart,
      textTheme: GoogleFonts.interTextTheme(
        TextTheme(
          displayLarge: GoogleFonts.poppins(
            color: textPrimary,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: GoogleFonts.poppins(
            color: textPrimary,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: GoogleFonts.poppins(
            color: textPrimary,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: GoogleFonts.poppins(
            color: textPrimary,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: GoogleFonts.poppins(
            color: textPrimary,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: GoogleFonts.poppins(
            color: textPrimary,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.poppins(
            color: textPrimary,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: GoogleFonts.poppins(
            color: textPrimary,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: GoogleFonts.poppins(
            color: textPrimary,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: GoogleFonts.poppins(color: textPrimary),
          bodyMedium: GoogleFonts.poppins(color: textPrimary),
          bodySmall: GoogleFonts.poppins(color: textSecondary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  // Custom Shadows
  static List<BoxShadow> get glowShadow => [
    BoxShadow(
      color: tealStart.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get fireGlowShadow => [
    BoxShadow(
      color: fireStart.withOpacity(0.4),
      blurRadius: 25,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: tealStart.withOpacity(0.1),
      blurRadius: 15,
      spreadRadius: 0,
      offset: const Offset(0, 4),
    ),
  ];

  final colorWhite = Colors.white;
}
