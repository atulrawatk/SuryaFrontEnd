import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/utils/styles/colors.dart';
import 'package:surya/app/utils/styles/dimens.dart';
import 'package:surya/app/utils/styles/theme_service.dart';

class EditTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  const EditTextField({Key? key,required this.controller,required this.hintText,required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: AppDimen.fontSize16,
            color: (ThemeService.isDark.value)
                ? AppColors.whiteColor
                : AppColors.textColor,
            fontWeight: FontWeight.w400,
          ),
          fillColor: Colors.transparent,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Get.theme.accentColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Get.theme.primaryColor),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.red),
          )),
    );
  }
}
