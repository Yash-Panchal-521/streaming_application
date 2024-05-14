import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class AppTheme {
  static ThemeData theme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0E34A0),
      onPrimary: Colors.white,
      secondary: Color(0xffE08E45),
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.yellow,
      surface: Color.fromARGB(255, 249, 255, 238),
      onSurface: Colors.black,
    ),
    textTheme: GoogleFonts.publicSansTextTheme(),
  );

  // Font sizes
  static double smallFontSize = 12;
  static double mediumFontSize = 16;
  static double largeFontSize = 20;

  // Padding
  static double smallPadding = 8;
  static double mediumPadding = 16;
  static double largePadding = 32;

  // Border radius
  static double smallBorderRadius = 4;
  static double mediumBorderRadius = 8;
  static double largeBorderRadius = 12;

  // Border sizes
  static double thinBorderSize = 1.0;
  static double mediumBorderSize = 2.0;
  static double thickBorderSize = 4.0;

  // Common widget dimensions
  static double commonWidth = 120.0;
  static double commonHeight = 40.0;

  // Additional widget dimensions
  static double largeWidth = 200.0;
  static double largeHeight = 60.0;

  static double extraLargeWidth = 300.0;
  static double extraLargeHeight = 80.0;
}
