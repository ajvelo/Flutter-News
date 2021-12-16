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
          headline1: GoogleFonts.lato(
              color: Colours.ktextColorOnLight,
              fontSize: 24,
              fontWeight: FontWeight.bold),
          headline2: GoogleFonts.lato(
              color: Colours.ktextColorOnLight,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          bodyText1: GoogleFonts.lato(
              color: Colours.ktextColorOnLight,
              fontSize: 16,
              fontWeight: FontWeight.normal),
          bodyText2: GoogleFonts.lato(
              color: Colours.ktextColorOnLight,
              fontSize: 12,
              fontWeight: FontWeight.normal)));
}
