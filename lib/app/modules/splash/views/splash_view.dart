import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/utils/images.dart';
import 'package:surya/app/utils/styles/colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.onReady();
    return Scaffold(
      backgroundColor: Get.isPlatformDarkMode?AppColors.darkGreyColor:AppColors.grey_100,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: Get.height/4,
              child: Image.asset(
                AppImages.appLogo,
              ),
            ),
          )
        ],
      ),
    );
  }
}
