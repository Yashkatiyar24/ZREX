import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  // Colors
  static const Color primaryColor = Colors.black;
  static const Color secondaryColor = Colors.white;
  static const Color igGrey = Color(0xFFFAFAFA);
  static const Color igBorder = Color(0xFFDBDBDB);
  static const Color igDarkGrey = Color(0xFF262626);
  static const Color igLightGrey = Color(0xFF8E8E8E);
  static const Color igBlue = Color(0xFF0095F6);
  static const Color igRed = Color(0xFFED4956);

  // Text Styles
  static TextStyle get titleStyle => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        letterSpacing: -0.2,
      );

  static TextStyle get bodyStyle => GoogleFonts.inter(
        fontSize: 14,
        color: primaryColor,
        letterSpacing: -0.1,
      );

  static TextStyle get captionStyle => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      );

  static TextStyle get greyStyle => GoogleFonts.inter(
        fontSize: 12,
        color: igLightGrey,
        letterSpacing: -0.1,
      );

  // Images
  static const String logoUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Instagram_logo.svg/1200px-Instagram_logo.svg.png';
}
