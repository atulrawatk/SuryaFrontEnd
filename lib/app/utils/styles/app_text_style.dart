import 'package:flutter/material.dart';

class AppTextStyle {
  const AppTextStyle._();

  static TextStyle heading1Style({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return _textStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle buttonTextStyle({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return _textStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle _textStyle({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: 'Helvetica Neue Ultra Light',
    );
  }
}
