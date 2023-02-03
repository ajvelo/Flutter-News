import 'package:flutter/material.dart';
import 'package:flutter_news/core/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static ThemeData appTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      primaryColor: Colors.blue,
      textTheme: TextTheme(
          displayLarge: GoogleFonts.lato(
              color: Colours.ktextColorOnLight,
              fontSize: 24,
              fontWeight: FontWeight.bold),
          displayMedium: GoogleFonts.lato(
              color: Colours.ktextColorOnLight,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          bodyLarge: GoogleFonts.lato(
              color: Colours.ktextColorOnLight,
              fontSize: 16,
              fontWeight: FontWeight.normal),
          bodyMedium: GoogleFonts.lato(
              color: Colours.ktextColorOnLight,
              fontSize: 12,
              fontWeight: FontWeight.normal)));
}
