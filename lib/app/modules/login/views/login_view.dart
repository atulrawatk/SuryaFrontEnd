import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/global_widgets/ios_back_button.dart';
import 'package:surya/app/global_widgets/mobile_textfield.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/weight.dart';
import '../controllers/login_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends GetView<LoginController> {
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
                    padding:  EdgeInsets.only(left:Get.height/40,top: Get.height/40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: SafeArea(
                              child: IosBackButton()),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SafeArea(
                            child: Text(AppStrings.enterNumberHint,
                              style: AppTextStyle.headingText(
                                  color: Get.theme.primaryColor,
                                  fontSize: Get.height/30,
                                  fontWeight: AppFontWeight.headingWeight),),
                          ),
                        ),
                        Container()
                      ],
                    ),
                  ),
                  Align(
                    alignment:Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top:Get.height/20,
                        left: Get.height/30,
                      right: Get.height/30),
                      child: Text(AppStrings.suryaWillSend,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.headingText(
                          color: Get.theme.accentColor,
                          fontSize:AppDimen.normalFontSize,
                          fontWeight: AppFontWeight.normalWeight),
                      ),
                    ) ,)
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding:  EdgeInsets.only(left: Get.height/25,right: Get.height/25),
                child: TextFormWidget(
                  textEditingController: controller.mobileController,
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  hintText: AppStrings.enterNumberHint, validator: (String? value) {  },
                  maxLength: 10,),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:  EdgeInsets.only(bottom:Get.height/30),
                child: CustomButton(text: AppStrings.nextBold,
                    onPress: (){
                      Get.toNamed(Routes.OTP);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
