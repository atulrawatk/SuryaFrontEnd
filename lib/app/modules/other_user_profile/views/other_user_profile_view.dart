import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/modules/chat/controllers/chat_controller.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/images.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/app_text_style.dart';
import 'package:surya/app/utils/styles/colors.dart';
import 'package:surya/app/utils/styles/theme_service.dart';
import 'package:surya/app/utils/utils.dart';
import 'package:video_player/video_player.dart';

import '../controllers/other_user_profile_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtherUserProfileView extends GetView<OtherUserProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeService.isDark.value
            ? AppColors.darkThemeBackground
            : AppColors.lightThemeBackground,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: IosBackButton(),
                ),
                expandedHeight: 220.h,
                floating: true,
                pinned: true,
                backgroundColor: AppColors.primaryDarkColor,
                flexibleSpace: FlexibleSpaceBar(
                    //centerTitle: true,
                    title: Text(controller.model.name!.value,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.h,
                        )),
                    background: Hero(
                      tag: "chat_head",
                      child: Image.asset(
                        AppImages.dummyProfileImage,
                        fit: BoxFit.none,
                      ),
                    )),
              ),
            ];
          },
          body: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                padding: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                    color: ThemeService.isDark.value
                        ? Colors.black26
                        : Colors.white.withOpacity(0.9)),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                            AppStrings.mediaLinks,
                            style: AppTextStyle.chatLabelText(),
                          )),
                          controller.mediaMessages.length > 0
                              ? Flexible(
                                  child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  onPressed: () {
                                    Get.toNamed(Routes.MEDIA_LINKS_DOCS,
                                        arguments: controller.model);
                                  },
                                ))
                              : Flexible(
                                  child: Container(),
                                )
                        ],
                      ),
                    ),
                    Container(
                      height: 100.h,
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Obx(() => controller.mediaMessages.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return controller.mediaMessages.length > 0
                                        ? Material(
                                            child: InkWell(
                                              onTap: () {
                                                ChatController chatController =
                                                    Get.find<ChatController>();
                                                if (controller
                                                        .mediaMessages[index]
                                                        .mediaType ==
                                                    "video") {
                                                  chatController
                                                          .mediaController
                                                          .videoController
                                                          .value =
                                                      VideoPlayerController
                                                          .file(File(controller
                                                              .mediaMessages[
                                                                  index]
                                                              .media!))
                                                        ..initialize()
                                                            .whenComplete(() {
                                                          Future.delayed(
                                                              Duration.zero,
                                                              () => Get.toNamed(
                                                                  Routes
                                                                      .CHAT_MEDIA));
                                                          chatController
                                                              .mediaController
                                                              .videoListeners();
                                                        });
                                                  chatController.mediaController
                                                          .chatModel =
                                                      controller
                                                          .mediaMessages[index];
                                                } else if (controller
                                                        .mediaMessages[index]
                                                        .mediaType ==
                                                    "image") {
                                                  Future.delayed(
                                                      Duration.zero,
                                                      () => Get.toNamed(
                                                          Routes.CHAT_MEDIA,
                                                          arguments: controller
                                                                  .mediaMessages[
                                                              index]));
                                                  chatController.mediaController
                                                          .chatModel =
                                                      controller
                                                          .mediaMessages[index];
                                                }
                                              },
                                              child: Container(
                                                  width: 120.h,
                                                  margin: EdgeInsets.only(
                                                      left: 5.w, right: 5.w),
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      image: controller
                                                                  .mediaMessages[
                                                                      index]
                                                                  .mediaType ==
                                                              "image"
                                                          ? DecorationImage(
                                                              image: FileImage(
                                                                  File(controller
                                                                      .mediaMessages[
                                                                          index]
                                                                      .media!)),
                                                              fit: BoxFit.cover)
                                                          : null),
                                                  child: controller
                                                              .mediaMessages[index]
                                                              .mediaType ==
                                                          "audio"
                                                      ? Center(child: Icon(Icons.audiotrack, color:
                                                  AppColors.whiteColor))
                                                      : controller.mediaMessages[index].mediaType == "video"
                                                          ? Center(
                                                              child: Icon(
                                                              Icons.play_arrow,
                                                              color:
                                                                  AppColors.whiteColor,
                                                            ))
                                                          : controller.mediaMessages[index].mediaType == "document"
                                                              ? Center(child: Icon(Icons.perm_media,color:
                                                  AppColors.whiteColor))
                                                              : Container()),
                                            ),
                                          )
                                        : Container();
                                  },
                                  itemCount: controller.mediaMessages.length,
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      EdgeInsets.only(top: 10.h, bottom: 10.h),
                                )
                              : Center(
                                  child: Text(
                                  AppStrings.thereIsNoMedia,
                                  style: AppTextStyle.mainPageHeading(),
                                )))),
                    ),
                  ],
                ),
              ),
              Material(
                color: ThemeService.isDark.value
                    ? Colors.transparent
                    : Colors.white.withOpacity(0.9),
                child: InkWell(
                  splashColor: ThemeService.isDark.value
                      ? Colors.grey[600]
                      : Colors.black,
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(top: 10.h),
                    decoration: BoxDecoration(
                        color: ThemeService.isDark.value
                            ? Colors.black26
                            : Colors.white.withOpacity(0.9)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15.w, top: 10.h),
                                child: Text(
                                  AppStrings.phoneNumber,
                                  style: AppTextStyle.chatLabelText(),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 15.h, left: 15.w, bottom: 20.h),
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Text(
                                      controller.model.number!,
                                      style: AppTextStyle.phoneNumber(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Text(
                                        AppStrings.mobile,
                                        style: AppTextStyle.nameHeading(),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    icon: Icon(Icons.message),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    icon: Icon(Icons.call),
                                    onPressed: () {
                                      Get.toNamed(Routes.AUDIO_CALLING);
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    icon: Icon(Icons.videocam),
                                    onPressed: () {
                                      Get.toNamed(Routes.AUDIO_CALLING);
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: ThemeService.isDark.value
                        ? Colors.black26
                        : Colors.white.withOpacity(0.9),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.block,
                          color: AppColors.red,
                          size: 20.h,
                        ),
                        title: Text(
                          AppStrings.block,
                          style: AppTextStyle.headingText(
                              color: AppColors.red,
                              fontSize: 17.h,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: ThemeService.isDark.value
                        ? Colors.black26
                        : Colors.white.withOpacity(0.9),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.clear,
                          color: AppColors.red,
                          size: 20.h,
                        ),
                        title: Text(
                          AppStrings.removeFromContact,
                          style: AppTextStyle.headingText(
                              color: AppColors.red,
                              fontSize: 17.h,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
