import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
    colorSchemeSeed: Colors.blue,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.fuzzyBubbles(),
      titleMedium: GoogleFonts.fuzzyBubbles(fontSize: 35),
    ),
  );
}
