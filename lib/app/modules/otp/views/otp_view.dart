import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:surya/app/global_widgets/ios_back_button.dart';
import 'package:surya/app/global_widgets/custom_button.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/app_text_style.dart';
import 'package:surya/app/utils/styles/colors.dart';
import 'package:surya/app/utils/styles/dimens.dart';
import 'package:surya/app/utils/styles/padding.dart';
import 'package:surya/app/utils/styles/weight.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:Get.height/40,top: Get.height/40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SafeArea(
                                child: IosBackButton()
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: SafeArea(
                              child: Text(AppStrings.verify,
                                style: AppTextStyle.headingText(
                                    color: Get.theme.primaryColor,
                                    fontSize: Get.height/30,
                                    fontWeight: AppFontWeight.headingWeight),),
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top:Get.height/20,
                      left: Get.height/30,right: Get.height/30),
                      child: Text(
                        AppStrings.smsSent,
                        style: AppTextStyle.headingText(
                            color: Get.theme.accentColor,
                            fontSize: AppDimen.normalFontSize,
                            fontWeight: AppFontWeight.normalWeight),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: AppPadding.otpFieldTopPadding,
                      height: Get.height/15,
                      width: Get.width/1.7,
                      child: PinCodeTextField(
                        length: 4,
                        obscureText: false,
                        cursorColor: Get.theme.primaryColor,
                        backgroundColor: Colors.transparent,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          inactiveFillColor: Colors.transparent,
                          selectedFillColor: Colors.transparent,
                          selectedColor: Get.theme.accentColor,
                          activeFillColor: Colors.transparent,
                          activeColor: Get.theme.primaryColor,
                          inactiveColor: Get.theme.accentColor,
                        ),
                        textStyle: AppTextStyle.headingText(
                            color: Get.theme.accentColor,
                            fontSize: Get.height/50,
                            fontWeight: AppFontWeight.headingWeight),
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: controller.errorController,
                        controller: controller.textEditingController,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        }, appContext: context,
                      ),
                    ),
                  ),
                  Align(
                    child: Padding(
                      padding:  EdgeInsets.only(top: Get.height/20),
                      child: Text(AppStrings.resendSms,
                      style: AppTextStyle.greyText(
                          color: Get.theme.primaryColor,
                          fontSize: Get.height/40,
                          fontWeight: AppFontWeight.normalWeight),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom:Get.height/20),
                child: CustomButton(text: AppStrings.confirm, onPress: (){}),
              ),
            )
          ],
        ),
      ),
    );
  }
}
