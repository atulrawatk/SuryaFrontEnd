import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/global_widgets/custom_button.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/images.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/app_text_style.dart';
import 'package:surya/app/utils/styles/colors.dart';
import 'package:surya/app/utils/styles/dimens.dart';
import 'package:surya/app/utils/styles/padding.dart';
import 'package:surya/app/utils/styles/weight.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          //color: Get.thAppColors.chatBg.withOpacity(0.4),
        ),
        child: SafeArea(
          child: Padding(
            padding: AppPadding.appPagePadding,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: Get.height/10),
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: Get.width/2.5,
                          width: Get.width/2.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Get.width/2),
                              image: DecorationImage(
                                  image: AssetImage(
                                    AppImages.appLogo,
                                  ),
                                  fit: BoxFit.fill
                              )
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding:  EdgeInsets.only(top:Get.height/10),
                          child: Text(AppStrings.welcomeText,
                            style: AppTextStyle.headingText(
                              color: Get.theme.accentColor,
                              fontSize: AppDimen.headingSize,
                              fontWeight: AppFontWeight.headingWeight),),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:  EdgeInsets.only(left:Get.height/50,
                        right: Get.height/50,bottom: Get.height/20),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(bottom: Get.height/40),
                          child: RichText(
                            text: TextSpan(
                            children: [
                              TextSpan(
                                text: AppStrings.readOur,
                              ),
                              TextSpan(
                                text: AppStrings.privacyPolicy,
                                style: AppTextStyle.greyText(
                                    color: AppColors.blue,
                                    fontSize: AppDimen.normalFontSize,
                                    fontWeight: AppFontWeight.normalWeight),
                                recognizer: new TapGestureRecognizer()..onTap = ()=>controller.launchURL()
                              ),
                              TextSpan(
                                text: AppStrings.tapAgreeAndContinue,
                              ),
                              TextSpan(
                                text: AppStrings.termsOfService,
                                  recognizer: new TapGestureRecognizer()..onTap = ()=>controller.launchURL(),
                                  style: AppTextStyle.greyText(
                                      color: AppColors.blue,
                                      fontSize: AppDimen.normalFontSize,
                                      fontWeight: AppFontWeight.normalWeight)
                              )
                            ],
                              style: AppTextStyle.greyText(
                          color: Get.theme.accentColor,
                              fontSize: AppDimen.normalFontSize,
                              fontWeight:AppFontWeight.normalWeight)
                          ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        CustomButton(text: AppStrings.agreeAndContinueBold,buttonColor: Get.theme.primaryColor,
                          onPress: (){
                          Get.toNamed(Routes.LOGIN);
                          },)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
