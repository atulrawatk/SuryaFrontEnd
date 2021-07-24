import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/utils/styles/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPress;
  final Color buttonColor;
  const CustomButton({Key? key,
  required this.text,
    required this.onPress,
    required this.buttonColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
        primary: buttonColor,
      //  padding: EdgeInsets.all(20),
        fixedSize: Size(
          Get.width / 2,
          Get.height/15
        ),
      ),
      onPressed: onPress,
      child: Text(text!,
        style: AppTextStyle.heading1Style(
            color: Get.theme.accentColor,
            fontSize: Get.height/45,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
