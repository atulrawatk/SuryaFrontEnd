import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:surya/app/utils/strings.dart';

import '../controllers/confirm_pin_controller.dart';

class ConfirmPinView extends GetView<ConfirmPinController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PasscodeScreen(
          title: Text(
            AppStrings.confirmPin,
            textAlign: TextAlign.center,
            style: TextStyle(color: Get.theme.primaryColor, fontSize: Get.height/30),
          ),
          circleUIConfig: CircleUIConfig(),
          keyboardUIConfig: KeyboardUIConfig(),
          passwordEnteredCallback: (String str){
            controller.confirmPin(str);
          },
          cancelButton: Text(
            AppStrings.cancel,
            style:  TextStyle(fontSize: Get.height/50, color: Colors.white),
            semanticsLabel: AppStrings.cancel,
          ),
          deleteButton: Text(
            AppStrings.delete,
            style:  TextStyle(fontSize: Get.height/50, color: Colors.white),
            semanticsLabel: AppStrings.delete,
          ),
          shouldTriggerVerification: controller.verificationNotifier.stream,
          backgroundColor: Colors.black.withOpacity(0.8),
          cancelCallback: (){
            Get.back();
          },
          digits: null,
          passwordDigits: 4,
          bottomWidget: null,
        )
    );
  }
}
