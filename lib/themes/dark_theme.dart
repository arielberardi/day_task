import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: const Color(0xFFFED36A),
    secondary: Colors.white,
    background: Colors.blueGrey[900],
    primaryContainer: const Color(0xFF455A64),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.ptSansNarrow(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 72,
        height: 1,
        fontWeight: FontWeight.bold,
      ),
    ),
    titleLarge: GoogleFonts.ptSansNarrow(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        height: 1,
        fontWeight: FontWeight.bold,
      ),
    ),
    labelLarge: ThemeData.dark().textTheme.labelLarge?.copyWith(
          color: const Color(0xFF8CAAB9),
        ),
    bodySmall: ThemeData.dark().textTheme.bodySmall?.copyWith(
          color: Colors.white,
        ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
  ),
);
