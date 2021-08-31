import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/utils/images.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/theme_service.dart';

import '../controllers/audio_calling_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioCallingView extends GetView<AudioCallingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeService.isDark.value?Get.theme.backgroundColor:Colors.white.withOpacity(0.9),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20.h),
                    height: 100.h,
                    width: 100.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        image: DecorationImage(
                            image: AssetImage(AppImages.dummyProfileImage))),
                  ),
                  Text(
                    AppStrings.name,
                    style: AppTextStyle.mainPageHeading(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Text(
                      AppStrings.calling,
                      style: AppTextStyle.nameHeading(),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundColor: !controller.isSpeakerOn.value
                                ? Colors.transparent
                                : ThemeService.isDark.value
                                    ? Colors.white
                                    : Colors.grey[400],
                            child: IconButton(
                              icon: Icon(
                                Icons.volume_up,
                                color: ThemeService.isDark.value
                                    ?!controller.isSpeakerOn.value?Get.theme.accentColor:Colors.black
                                    : Colors.black,
                              ),
                              onPressed: () {
                                controller.isSpeakerOn.value =
                                    !controller.isSpeakerOn.value;
                              },
                            ),
                          ),
                          CircleAvatar(
                            radius: 30.r,
                            backgroundColor: !controller.isVideoOn.value
                                ? Colors.transparent
                                : ThemeService.isDark.value
                                    ? Colors.white
                                    : Colors.grey[400],
                            child: IconButton(
                              icon: Icon(
                                Icons.videocam_off,
                                color: ThemeService.isDark.value
                                    ? !controller.isVideoOn.value?Get.theme.accentColor:Colors.black
                                    : Colors.black,
                              ),
                              onPressed: () {
                                controller.isVideoOn.value =
                                    !controller.isVideoOn.value;
                              },
                            ),
                          ),
                          CircleAvatar(
                            radius: 30.r,
                            backgroundColor: !controller.isMute.value
                                ? Colors.transparent
                                : ThemeService.isDark.value
                                    ? Colors.white
                                    : Colors.grey[400],
                            child: IconButton(
                              icon: Icon(
                                Icons.mic_off,
                                color: ThemeService.isDark.value
                                    ? !controller.isMute.value?Get.theme.accentColor:Colors.black
                                    : Colors.black,
                              ),
                              onPressed: () {
                                controller.isMute.value =
                                    !controller.isMute.value;
                              },
                            ),
                          ),
                          CircleAvatar(
                            radius: 30.r,
                            backgroundColor: AppColors.red,
                            child: IconButton(
                              icon: Icon(
                                Icons.call_end,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          )
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
