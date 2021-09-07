import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:surya/app/data/models/chat_user_model.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/global_widgets/user_image_edit_menu.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/images.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/app_text_style.dart';
import 'package:surya/app/utils/styles/colors.dart';
import 'package:surya/app/utils/styles/theme_service.dart';
import 'package:surya/app/utils/utils.dart';

import '../controllers/new_group_name_chat_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewGroupNameChatView extends GetView<NewGroupNameChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IosBackButton(),
        title: Text(
          AppStrings.groupName,
          style: AppTextStyle.mainPageHeading(),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: controller.key,
        child: Container(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: ThemeService.isDark.value
                            ? Colors.grey[900]
                            : AppColors.lightThemeBackground),
                    padding:
                        EdgeInsets.only(left: 20.w, top: 10.h, bottom: 20.h),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Hero(
                                tag: "profile_image",
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Get.bottomSheet(
                                          Container(
                                            height: 100.h,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                UserImageEditMenu(
                                                  callback: () {
                                                    controller
                                                        .imagePicker(
                                                            ImageSource.camera)
                                                        .whenComplete(() {
                                                      Get.back();
                                                    });
                                                  },
                                                  hintText: AppStrings.camera,
                                                  icon: Icon(Icons.camera),
                                                ),
                                                UserImageEditMenu(
                                                  callback: () {
                                                    controller
                                                        .imagePicker(
                                                            ImageSource.gallery)
                                                        .whenComplete(() {
                                                      Get.back();
                                                    });
                                                  },
                                                  hintText: AppStrings.gallery,
                                                  icon: Icon(Icons.image),
                                                ),
                                                UserImageEditMenu(
                                                  callback: () {
                                                    controller.profileImage
                                                        .value = File("");
                                                    Get.back();
                                                  },
                                                  hintText:
                                                      AppStrings.removeImage,
                                                  icon:
                                                      Icon(Icons.remove_circle),
                                                )
                                              ],
                                            ),
                                          ),
                                          backgroundColor:
                                              ThemeService.isDark.value
                                                  ? AppColors.snackBarColor
                                                  : AppColors.grey_350);
                                    },
                                    child: CircleAvatar(
                                      radius: 30.r,
                                      child: Obx(() => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                              image: DecorationImage(
                                                  image: !controller
                                                              .setProfileImage
                                                              .value ||
                                                          controller
                                                                  .profileImage
                                                                  .value
                                                                  .path ==
                                                              ""
                                                      ? Image.asset(AppImages
                                                              .dummyProfileImage)
                                                          .image
                                                      : Image.file(controller
                                                              .profileImage
                                                              .value)
                                                          .image,
                                                  fit: BoxFit.fill),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                ),
                                child: TextFormWidget(
                                    textEditingController:
                                        controller.groupNameController,
                                    textInputAction: TextInputAction.done,
                                    textInputType: TextInputType.name,
                                    hintText: AppStrings.enterGroupName,
                                    maxLength: 10,
                                    validator: Validators.name,
                                    formatter: []),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            AppStrings.provideGroupSubject,
                            style: AppTextStyle.nameHeading(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: Text(
                      AppStrings.participants +
                          ": " +
                          controller.contactUsers.value.length.toString(),
                      style: AppTextStyle.nameHeading(),
                    ),
                  ),
                  GridView.count(
                    childAspectRatio: (1 / 1),
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10.h),
                    crossAxisCount: 4,
                    children: List.generate(
                        controller.contactUsers.value.length, (index) {
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          CircleAvatar(
                            radius: 25.r,
                            child: Image.asset(AppImages.dummyProfileImage),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Center(
                                child: Text(
                                    controller.contactUsers.value[index].name)),
                          )
                        ],
                      );
                    }),
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                      child: Padding(
                    padding: EdgeInsets.all(10.h),
                    child: ElevatedButton(
                        onPressed: () {
                          controller.toGroupChat();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Text(
                            AppStrings.createGroup,
                            style: AppTextStyle.nameHeading(),
                          ),
                        )),
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
