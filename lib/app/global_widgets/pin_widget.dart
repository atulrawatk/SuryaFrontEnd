import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:surya/app/modules/createPin/controllers/create_pin_controller.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
class PinWidget extends StatelessWidget {
  final CreatePinController controller;
  final bool isAuthenticated = false;
  PinWidget({Key? key,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PasscodeScreen(
      title: Text(
        'Enter App Passcode',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 28),
      ),
      circleUIConfig: CircleUIConfig(),
      keyboardUIConfig: KeyboardUIConfig(),
      passwordEnteredCallback: (String str){

      },
      cancelButton: Text(
        'Cancel',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'Cancel',
      ),
      deleteButton: Text(
        'Delete',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'Delete',
      ),
      shouldTriggerVerification: controller.verificationNotifier.stream,
      backgroundColor: Colors.black.withOpacity(0.8),
      cancelCallback: (){
        Get.back();
      },
      digits: null,
      passwordDigits: 6,
      bottomWidget: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: TextButton(
            child: Text(
              "Reset passcode",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
            onPressed: (){
              Navigator.maybePop(context).then((result) {
                if (!result) {
                  return;
                }

              });
            },
            // splashColor: Colors.white.withOpacity(0.4),
            // highlightColor: Colors.white.withOpacity(0.2),
            // ),
          ),
        ),
      ),
    );
  }
}
