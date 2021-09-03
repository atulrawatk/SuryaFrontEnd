import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/colors.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/weight.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  static TextStyle groupChatName() {
    return _textStyle(
        color: Get.theme.accentColor,
        fontSize: 15.h,
        fontWeight: FontWeight.bold);
  }

  static TextStyle mainPageHeading() {
    return _textStyle(
        color: Get.theme.accentColor,
        fontSize: 17.h,
        fontWeight: FontWeight.bold);
  }

  static TextStyle repliedUserNameChat() {
    return TextStyle(
        color: Get.theme.primaryColor,
        fontFamily: AppStrings.appFontFamily,
        fontSize: 15.h,
        fontWeight: FontWeight.bold);
  }

  static TextStyle chatLabelText() {
    return _textStyle(
        color: Get.theme.accentColor,
        fontSize: 15.h,
        fontWeight: FontWeight.bold);
  }

  static TextStyle pinPattern() {
    return _textStyle(
        color: Get.theme.primaryColor,
        fontSize: Get.height / 40,
        fontWeight: AppFontWeight.headingWeight);
  }

  static TextStyle normalText() {
    return _textStyle(
        color: Get.theme.accentColor,
        fontSize: AppDimen.normalFontSize,
        fontWeight: AppFontWeight.normalWeight);
  }

  static TextStyle phoneNumber() {
    return TextStyle(
        fontFamily: AppStrings.appFontFamily,
        color: Get.theme.accentColor,
        fontSize: 18.h,
        letterSpacing: 1.w);
  }

  static TextStyle headingText(
      {required Color color,
      required double fontSize,
      required FontWeight fontWeight}) {
    return _textStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  static TextStyle nameHeading() {
    return _textStyle(
        color: Get.theme.accentColor,
        fontSize: 13.h,
        fontWeight: FontWeight.normal);
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

  static TextStyle greyText(
      {required Color color,
      required double fontSize,
      required FontWeight fontWeight}) {
    return _textStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  static TextStyle multiChatName() {
    return TextStyle(
      color: Get.theme.accentColor,
      fontSize: Get.height / 40,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      fontFamily: AppStrings.appFontFamily,
    );
  }

  static TextStyle multiChatMessage() {
    return TextStyle(
      color: Get.theme.accentColor,
      fontSize: Get.height / 50,
      fontWeight: FontWeight.normal,
      fontFamily: AppStrings.appFontFamily,
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
      fontFamily: AppStrings.appFontFamily,
    );
  }
}
