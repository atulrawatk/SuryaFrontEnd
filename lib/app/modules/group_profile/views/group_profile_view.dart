import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/modules/group_chat/controllers/group_chat_controller.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/enum_navigation.dart';
import 'package:surya/app/utils/images.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/colors.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/theme_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../controllers/group_profile_controller.dart';

class GroupProfileView extends GetView<GroupProfileController> {
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
                    title: Text("Tushar",
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
                                onPressed: () {},
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
                                    GroupChatController chatController =
                                    Get.find<GroupChatController>();
                                    if(controller.mediaMessages[index].mediaType==MediaType.video){
                                      chatController
                                          .mediaController
                                          .videoController
                                          .value =
                                      VideoPlayerController
                                          .file(
                                          controller.mediaMessages[index]
                                              .media)
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
                                      chatController
                                          .mediaController
                                          .chatModel =
                                      controller.mediaMessages[index];
                                    }
                                    else if(controller.mediaMessages[index].mediaType==MediaType.image){
                                      Future.delayed(
                                          Duration.zero,
                                              () => Get.toNamed(
                                              Routes.CHAT_MEDIA,arguments: controller.mediaMessages[index]));
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
                                          image: controller.mediaMessages[index].mediaType ==
                                              MediaType.image
                                              ? DecorationImage(
                                              image: FileImage(
                                                  controller
                                                      .mediaMessages[
                                                  index]
                                                      .media),
                                              fit: BoxFit.cover)
                                              : null),
                                      child: controller.mediaMessages[index].mediaType ==
                                          MediaType.audio
                                          ? Center(
                                          child: Icon(
                                              Icons.audiotrack))
                                          : controller.mediaMessages[index]
                                          .mediaType ==
                                          MediaType.video
                                          ? Center(child: Icon(Icons.play_arrow))
                                          : controller.mediaMessages[index].mediaType == MediaType.document
                                          ? Center(child: Text(controller.mediaMessages[index].message))
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
              Container(
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
                                  "+91 7011575173",
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
                            child: IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {},
                            ),
                          ),
                          Flexible(
                            child: IconButton(
                              icon: Icon(Icons.call),
                              onPressed: () {},
                            ),
                          ),
                          Flexible(
                            child: IconButton(
                              icon: Icon(Icons.videocam),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding:
                      EdgeInsets.only(left: 15.w, top: 20.h, bottom: 20.h),
                      decoration: BoxDecoration(
                        color: ThemeService.isDark.value
                            ? Colors.black26
                            : Colors.white.withOpacity(0.9),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                              child: Icon(
                                Icons.block,
                                color: AppColors.red,
                                size: 25.h,
                              )),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.w),
                              child: Text(
                                AppStrings.block,
                                style: AppTextStyle.headingText(
                                    color: AppColors.red,
                                    fontSize: 17.h,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding:
                      EdgeInsets.only(left: 15.w, top: 20.h, bottom: 20.h),
                      decoration: BoxDecoration(
                        color: ThemeService.isDark.value
                            ? Colors.black26
                            : Colors.white.withOpacity(0.9),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                              child: Icon(
                                Icons.clear,
                                color: AppColors.red,
                                size: 25.h,
                              )),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 30.w),
                              child: Text(
                                AppStrings.removeFromContact,
                                style: AppTextStyle.headingText(
                                    color: AppColors.red,
                                    fontSize: 17.h,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
