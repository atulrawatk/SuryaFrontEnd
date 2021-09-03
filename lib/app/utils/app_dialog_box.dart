import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'styles/custom_styles.dart';
import 'styles/theme_service.dart';

class AppDialogBox {
  //
  AppDialogBox._();

  static void showDialog(
    String message, {
    required String title,
    bool success = false,
    required Function() onTapYes,
    required Function() onTapNo,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async {
          Get.back();

          // onTap?.call();

          return true;
        },
        title: title,
        backgroundColor:
            ThemeService.isDark.value ? AppColors.snackBarColor : Colors.white,
        titleStyle: AppTextStyle.chatLabelText(),
        content: Text(
          message,
          textAlign: TextAlign.center,
          maxLines: 6,
          style: AppTextStyle.buttonTextStyle(
            color: Get.theme.accentColor,
            fontSize: AppDimen.fontSize16,
            fontWeight: FontWeight.normal,
          ),
        ),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back();

                  onTapYes.call();
                },
                child: Text(
                  AppStrings.yes,
                  style: AppTextStyle.buttonTextStyle(
                    fontSize: AppDimen.fontSize18,
                    color: Get.theme.accentColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();

                  onTapNo.call();
                },
                child: Text(
                  AppStrings.no,
                  style: AppTextStyle.buttonTextStyle(
                    fontSize: AppDimen.fontSize18,
                    color: Get.theme.accentColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
        ),
      );
}
