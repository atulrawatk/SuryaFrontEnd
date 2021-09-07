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
                    title: Text(controller.groupModel.name.value,
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
                                                GroupChatController
                                                    chatController = Get.find<
                                                        GroupChatController>();
                                                if (controller
                                                        .mediaMessages[index]
                                                        .mediaType ==
                                                    MediaType.video) {
                                                  chatController
                                                          .mediaController
                                                          .videoController
                                                          .value =
                                                      VideoPlayerController
                                                          .file(controller
                                                              .mediaMessages[
                                                                  index]
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
                                                  chatController.mediaController
                                                          .chatModel =
                                                      controller
                                                          .mediaMessages[index];
                                                } else if (controller
                                                        .mediaMessages[index]
                                                        .mediaType ==
                                                    MediaType.image) {
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
                                                              MediaType.image
                                                          ? DecorationImage(
                                                              image: FileImage(controller
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
                                                      : controller.mediaMessages[index].mediaType ==
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
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, top: 5.h, bottom: 5.h),
                      child: Text(
                        controller.groupModel.users.length.toString() +
                            " " +
                            AppStrings.participants,
                        style: AppTextStyle.repliedUserNameChat(),
                      ),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: ListTile(
                            onTap: () {},
                            title: Text(
                              controller.groupModel.users[index].name.value,
                              style: AppTextStyle.chatLabelText(),
                            ),
                            leading: CircleAvatar(
                              child: controller.groupModel.users[index]
                                              .profileImage.value.path ==
                                          null ||
                                      controller.groupModel.users[index]
                                              .profileImage.value.path ==
                                          ""
                                  ? Image.asset(AppImages.dummyProfileImage)
                                  : Image.file(controller.groupModel
                                      .users[index].profileImage.value),
                              radius: 20.r,
                            ),
                            subtitle: Text(
                              controller.groupModel.users[index].number,
                              style: AppTextStyle.nameHeading(),
                            ),
                          ),
                        );
                      },
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.groupModel.users.length,
                    )
                  ],
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
                          Icons.exit_to_app,
                          color: AppColors.red,
                          size: 20.h,
                        ),
                        title: Text(
                          AppStrings.exitGroup,
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
                          Icons.thumb_down_sharp,
                          color: AppColors.red,
                          size: 20.h,
                        ),
                        title: Text(
                          AppStrings.reportGroup,
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
