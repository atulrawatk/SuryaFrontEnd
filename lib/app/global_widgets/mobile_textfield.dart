import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:surya/app/utils/styles/colors.dart';
import 'package:surya/app/utils/styles/dimens.dart';

class TextFormWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? hintText;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter> formatter;
  const TextFormWidget(
      {required this.textEditingController,
      required this.textInputAction,
      required this.textInputType,
      required this.hintText,
      required this.maxLength,
      required this.validator,
      required this.formatter});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      validator: validator,
      controller: textEditingController,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      inputFormatters: formatter,
      autofocus: false,
      buildCounter: (BuildContext? context,
              {int? currentLength, int? maxLength, bool? isFocused}) =>
          null,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: AppDimen.fontSize16,
            color: (Get.isPlatformDarkMode)
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
      style: TextStyle(
        fontSize: AppDimen.fontSize16,
        color: (Get.isPlatformDarkMode)
            ? AppColors.whiteColor
            : AppColors.textColor,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
