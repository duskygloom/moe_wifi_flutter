import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static OutlineInputBorder _border({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 2,
        color: color,
        style: BorderStyle.solid,
      ),
    );
  }

  static const mobileWidth = 600;

  static Color get activeColor => const Color.fromARGB(255, 10, 148, 58);

  static TextStyle get titleTextTheme =>
      GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.bold);

  static ThemeData get themeData => ThemeData.dark().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          enabledBorder: _border(color: Colors.blueAccent.shade100),
          focusedBorder: _border(color: Colors.blueAccent.shade400),
          errorBorder: _border(color: Colors.redAccent.shade100),
          focusedErrorBorder: _border(color: Colors.redAccent.shade100),
          disabledBorder: _border(color: Colors.grey),
          hintStyle: GoogleFonts.lexend(),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(
              GoogleFonts.lexend(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(
            GoogleFonts.lexend(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      );
}
