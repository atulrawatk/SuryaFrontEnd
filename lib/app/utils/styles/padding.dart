import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppPadding{

  static final EdgeInsets otpFieldTopPadding=EdgeInsets.only(top:Get.height/20);

  //Padding App Global
  static final EdgeInsets appPagePadding=EdgeInsets.only(
    top:Get.height/30,
    left:Get.height/30,
      right: Get.height/30,
  );

  static final EdgeInsets multiChatPadding=EdgeInsets.only(
    left: Get.height/50,right: Get.height/50,
      top: Get.height/80,
      bottom: Get.height/80
  );
}