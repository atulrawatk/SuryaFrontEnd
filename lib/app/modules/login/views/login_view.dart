import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/global_widgets/ios_back_button.dart';
import 'package:surya/app/global_widgets/mobile_textfield.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/padding.dart';
import 'package:surya/app/utils/styles/weight.dart';
import 'package:surya/app/utils/validators.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: controller.loginKey,
            child: Padding(
            padding: AppPadding.appPagePadding,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: SafeArea(child: IosBackButton()),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: Get.height / 3),
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SafeArea(
                          child: Text(
                            AppStrings.enterNumberHint,
                            style: AppTextStyle.headingText(
                                color: Get.theme.primaryColor,
                                fontSize: Get.height / 30,
                                fontWeight: AppFontWeight.headingWeight),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Get.height / 20,
                              left: Get.height / 30,
                              right: Get.height / 30),
                          child: Text(
                            AppStrings.suryaWillSend,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.headingText(
                                color: Get.theme.accentColor,
                                fontSize: AppDimen.normalFontSize,
                                fontWeight: AppFontWeight.normalWeight),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height / 10),
                          child: TextFormWidget(
                            textEditingController: controller.mobileController,
                            textInputType: TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false
                            ),
                            textInputAction: TextInputAction.go,
                            hintText: AppStrings.enterNumberHint,
                            validator: Validators.mobileNumber,
                            maxLength: 10,
                            formatter: [FilteringTextInputFormatter.digitsOnly],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: Get.height / 30),
                    child: CustomButton(
                        text: AppStrings.nextBold,
                        buttonColor: Get.theme.primaryColor,
                        onPress: () {
                          if (controller.loginKey.currentState!.validate()) {
                            controller.signIn();
                          }
                        }),
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
