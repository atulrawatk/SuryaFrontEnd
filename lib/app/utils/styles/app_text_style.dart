import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/utils/styles/colors.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/weight.dart';

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
  static TextStyle pinPattern(){
    return _textStyle(color: Get.theme.primaryColor,
        fontSize: Get.height/40,
        fontWeight: AppFontWeight.headingWeight);
  }

  static TextStyle normalText(){
    return _textStyle(
        color: Get.theme.accentColor,
        fontSize: AppDimen.normalFontSize,
        fontWeight: AppFontWeight.normalWeight);
  }
  static TextStyle headingText({
  required Color color ,
    required double fontSize,
    required FontWeight fontWeight
  }){
    return _textStyle(color: color,
        fontSize: fontSize,
        fontWeight: fontWeight);

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

  static TextStyle greyText({
    required Color color,
    required double fontSize,
   required FontWeight fontWeight
  }){
    return _textStyle(color: color,
        fontSize: fontSize,
        fontWeight: fontWeight);

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
