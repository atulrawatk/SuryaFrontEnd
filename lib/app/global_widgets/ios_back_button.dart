import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/utils/styles/colors.dart';
class IosBackButton extends StatelessWidget {
  const IosBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      padding: EdgeInsets.zero,
      onPressed: (){
        Get.back();
      },
    );
  }
}
