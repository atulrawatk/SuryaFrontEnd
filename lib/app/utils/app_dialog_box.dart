import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surya/app/global_widgets/edit_user_text_field.dart';
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

  //
  static Widget groupNameChange({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required Function() onTapYes,
    required Function() onTapNo,
    required String buttontext1,
    required String buttontext2,
  }) =>
      SimpleDialog(
        title: Text(
          AppStrings.enterNewSubject,
          textAlign: TextAlign.center,
        ),
        titleTextStyle: AppTextStyle.chatLabelText(),
        backgroundColor:
            ThemeService.isDark.value ? AppColors.snackBarColor : Colors.white,
        children: [
          Container(
            margin: EdgeInsets.all(10.r),
            child: EditTextField(
              controller: controller,
              focusNode: FocusNode(),
              hintText: hintText,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  onTapYes.call();
                },
                child: Text(
                  buttontext1,
                  style: AppTextStyle.normalText(),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              ElevatedButton(
                onPressed: () {
                  onTapNo.call();
                },
                child: Text(buttontext2, style: AppTextStyle.normalText()),
              ),
              SizedBox(
                width: 10.w,
              )
            ],
          )
        ],
      );

  static Widget removeGroup({
    required FocusNode focusNode,
    required String hintText,
    required Function() onTapYes,
    required Function() onTapNo,
    required String buttontext1,
    required String buttontext2,
  }) =>
      SimpleDialog(
        title: Text(
          hintText,
          textAlign: TextAlign.center,
        ),
        titleTextStyle: AppTextStyle.chatLabelText(),
        backgroundColor:
            ThemeService.isDark.value ? AppColors.snackBarColor : Colors.white,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  onTapYes.call();
                },
                child: Text(
                  buttontext1,
                  style: AppTextStyle.normalText(),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              ElevatedButton(
                onPressed: () {
                  onTapNo.call();
                },
                child: Text(buttontext2, style: AppTextStyle.normalText()),
              ),
              SizedBox(
                width: 10.w,
              )
            ],
          )
        ],
      );

  // report group
  static Widget reportGroup({
    required FocusNode focusNode,
    required String title,
    required String message,
    required String message2,
    required Function() onTapYes,
    required Function() onTapNo,
    required String buttontext1,
    required String buttontext2,
    required void Function(bool?)? onChanged,
    required bool? value,
  }) =>
      SimpleDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        titleTextStyle: AppTextStyle.chatLabelText(),
        contentPadding: EdgeInsets.all(10.r),
        backgroundColor:
            ThemeService.isDark.value ? AppColors.snackBarColor : Colors.white,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyle.chatLabelText().copyWith(
              fontSize: 12.sp,
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: value,
                onChanged: onChanged,
                fillColor: MaterialStateProperty.all(
                  AppColors.primaryDarkColor,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                message2,
                textAlign: TextAlign.center,
                style: AppTextStyle.chatLabelText().copyWith(
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  onTapYes.call();
                },
                child: Text(
                  buttontext1,
                  style: AppTextStyle.normalText(),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              ElevatedButton(
                onPressed: () {
                  onTapNo.call();
                },
                child: Text(buttontext2, style: AppTextStyle.normalText()),
              ),
              SizedBox(
                width: 10.w,
              )
            ],
          )
        ],
      );
}
