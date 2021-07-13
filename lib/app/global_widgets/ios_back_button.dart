import 'package:flutter/material.dart';
import 'package:get/get.dart';
class IosBackButton extends StatelessWidget {
  const IosBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){Get.back();},
      child: Container(
          height: Get.height/30,
          width: Get.height/30,
          child: Icon(Icons.arrow_back_ios,size: Get.height/30,)),
    );
  }
}
