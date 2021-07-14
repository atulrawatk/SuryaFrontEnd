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
          color: AppColors.chatBg.withOpacity(0.1),
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage),
            fit: BoxFit.fill
          )
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top:Get.height/40),
                  child: Text(AppStrings.welcomeText,
                    style: AppTextStyle.headingText(
                      color: Get.theme.primaryColor,
                      fontSize: AppDimen.headingSize,
                      fontWeight: AppFontWeight.headingWeight),),
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
                                  fontWeight: AppFontWeight.normalWeight)
                            ),
                            TextSpan(
                              text: AppStrings.tapAgreeAndContinue,
                            ),
                            TextSpan(
                              text: AppStrings.termsOfService,
                                style: AppTextStyle.greyText(
                                    color: AppColors.blue,
                                    fontSize: AppDimen.normalFontSize,
                                    fontWeight: AppFontWeight.normalWeight)
                            )
                          ],
                            style: AppTextStyle.greyText(
                        color: AppColors.grey_500,
                            fontSize: AppDimen.normalFontSize,
                            fontWeight:AppFontWeight.normalWeight)
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CustomButton(text: AppStrings.agreeAndContinueBold,onPress: (){
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
    );
  }
}
