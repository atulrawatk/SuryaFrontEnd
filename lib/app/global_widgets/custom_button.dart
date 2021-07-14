import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/utils/styles/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPress;
  const CustomButton({Key? key,
  required this.text,
    required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
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
