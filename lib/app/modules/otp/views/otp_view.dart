import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:surya/app/global_widgets/ios_back_button.dart';
import 'package:surya/app/global_widgets/custom_button.dart';
import 'package:surya/app/routes/app_pages.dart';
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
        child: Padding(
          padding: AppPadding.appPagePadding,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SafeArea(
                    child: IosBackButton()
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ListView(
                  padding: EdgeInsets.only(bottom: Get.height/3),
                  shrinkWrap: true,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SafeArea(
                        child: Text(AppStrings.verify,
                          style: AppTextStyle.headingText(
                              color: Get.theme.primaryColor,
                              fontSize: Get.height/30,
                              fontWeight: AppFontWeight.headingWeight),),
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
                          controller: controller.otpController,
                          onCompleted: (v) {
                            //controller.isolateVerifyOtp();
                           controller.otpVerify();
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
                    Obx(()=>Align(
                      child: Padding(
                        padding:  EdgeInsets.only(top: Get.height/20),
                        child: GestureDetector(
                          onTap: (){
                            if(!controller.resendOtpTimer){
                              controller.setResendOtpTimer=true;
                              controller.timerStart();
                              controller.resendOtp();
                            }
                          },
                          child: controller.resendOtpTimer?
                          Container(
                            height: Get.height/12,
                            // color: Colors.white,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(AppStrings.resendSmsIn+" ",
                                    style: AppTextStyle.greyText(
                                        color: AppColors.grey_500,
                                        fontSize: Get.height/45,
                                        fontWeight: AppFontWeight.normalWeight),
                                  ),Icon(Icons.access_time,color: AppColors.grey_500,size:Get.height/45 ,),
                                  Text(controller.timerString(),
                                    style: AppTextStyle.greyText(
                                        color: AppColors.grey_500,
                                        fontSize: Get.height/45,
                                        fontWeight: AppFontWeight.normalWeight),
                                  )
                                ],
                              ),
                            ),
                          ):
                          Container(
                            height: Get.height/12,
                            //width: Get.width/2.5,
                            // color: Colors.white,
                            child: Center(
                              child: Text(AppStrings.resendSms,
                                style: AppTextStyle.greyText(
                                    color: Get.theme.primaryColor,
                                    fontSize: Get.height/45,
                                    fontWeight: AppFontWeight.normalWeight),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom:Get.height/20),
                  child: Obx(()=>CustomButton(text: controller.otpStatusCheck(),
                      buttonColor:controller.otpButtonCheck(),
                      onPress: (){controller.otpVerify();}),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
