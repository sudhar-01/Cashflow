// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget SansSerif(String text, FontWeight fontWeight, FontStyle fontStyle,
    double fontSize, Color fontColor) {
  return Text(text,
      style: GoogleFonts.openSans(
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          fontSize: fontSize,
          color: fontColor));
}

Widget Serif(String text, FontWeight fontWeight, FontStyle fontStyle,
    double fontSize, Color fontColor) {
  return Text(text,
      style: GoogleFonts.lora(
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          fontSize: fontSize,
          color: fontColor));
}

Widget Display(String text, FontWeight fontWeight, FontStyle fontStyle,
    double fontSize, Color fontColor) {
  return Text(text,
      style: GoogleFonts.lobster(
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          fontSize: fontSize,
          color: fontColor));
}

const FontWeight regularFont = FontWeight.normal;
const FontWeight mediumFont = FontWeight.w500;
const FontWeight semiboldFont = FontWeight.w600;
const FontWeight boldFont = FontWeight.bold;
