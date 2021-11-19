import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFont {
  static TextStyle getTextStyle(double size, Color color , FontWeight weight) {
    return GoogleFonts.lato(
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }
}