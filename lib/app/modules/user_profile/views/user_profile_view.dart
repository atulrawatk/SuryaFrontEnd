import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surya/app/data/storage/flutter_secure/user.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/global_widgets/edit_user_text_field.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/global_widgets/profile_image.dart';
import 'package:surya/app/global_widgets/user_image_edit_menu.dart';
import 'package:surya/app/utils/app_dialog_box.dart';
import 'package:surya/app/utils/images.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/theme_service.dart';

import '../controllers/user_profile_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileView extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IosBackButton(),
        title: Text(
          AppStrings.settings.trim(),
          style: AppTextStyle.mainPageHeading(),
        ),
        //centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Obx(
                    () => Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ProfileImage(
                              profileImage: controller.profileImage.value));
                        },
                        child: Hero(
                          tag: "profile_image",
                          child: Container(
                            height: 150.h,
                            width: 150.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              image: DecorationImage(
                                  image: !controller.setProfileImage.value ||
                                          controller.profileImage.value.path ==
                                              ""
                                      ? Image.asset(AppImages.dummyProfileImage)
                                          .image
                                      : Image.file(
                                              controller.profileImage.value)
                                          .image,
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Get.theme.primaryColor,
                    child: IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                              Container(
                                height: 100.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    UserImageEditMenu(
                                      callback: () {
                                        controller
                                            .imagePicker(ImageSource.camera)
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
                                            .imagePicker(ImageSource.gallery)
                                            .whenComplete(() {
                                          Get.back();
                                        });
                                      },
                                      hintText: AppStrings.gallery,
                                      icon: Icon(Icons.image),
                                    ),
                                    UserImageEditMenu(
                                      callback: () {
                                        controller.profileImage.value =
                                            File("");
                                        Get.back();
                                      },
                                      hintText: AppStrings.removeImage,
                                      icon: Icon(Icons.remove_circle),
                                    )
                                  ],
                                ),
                              ),
                              backgroundColor: ThemeService.isDark.value
                                  ? AppColors.snackBarColor
                                  : AppColors.grey_350);
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: Get.theme.accentColor,
                        )),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: Row(
              children: [
                Expanded(child: Icon(Icons.people)),
                Expanded(
                  flex: 3,
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.name,
                            style: AppTextStyle.nameHeading(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                            child: Text(
                              controller.nameString.value,
                              style: AppTextStyle.chatLabelText(),
                            ),
                          ),
                          Text(AppStrings.thisNameIsVisible)
                        ],
                      )),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Get.theme.primaryColor,
                    ),
                    onPressed: () {
                      controller.nameFocusNode.requestFocus();
                      Get.bottomSheet(
                        Container(
                          height: 150.h,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, top: 20.h, right: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.name,
                                  style: AppTextStyle.chatLabelText(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: EditTextField(
                                    controller: controller.nameController.value,
                                    hintText: AppStrings.name,
                                    focusNode: controller.nameFocusNode,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          controller.nameString.value =
                                              controller
                                                  .nameController.value.text;
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 15.w),
                                          child: Text(AppStrings.save,
                                              style: AppTextStyle
                                                  .repliedUserNameChat()),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 15.w),
                                          child: Text(
                                            AppStrings.cancel,
                                            style: AppTextStyle
                                                .repliedUserNameChat(),
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
                        backgroundColor: ThemeService.isDark.value
                            ? AppColors.snackBarColor
                            : AppColors.grey_350,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Row(
              children: [
                Expanded(child: Icon(Icons.info_outline)),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.about,
                        style: AppTextStyle.nameHeading(),
                      ),
                      Obx(() => Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              controller.aboutString.value,
                              style: AppTextStyle.chatLabelText(),
                            ),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Get.theme.primaryColor,
                    ),
                    onPressed: () {
                      controller.aboutFocusNode.requestFocus();
                      Get.bottomSheet(
                        Container(
                          height: 150.h,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, top: 20.h, right: 20.w),
                            child: Column(
                              //  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    AppStrings.about,
                                    style: AppTextStyle.chatLabelText(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: EditTextField(
                                    controller:
                                        controller.aboutController.value,
                                    hintText: 'About',
                                    focusNode: controller.aboutFocusNode,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          controller.aboutString.value =
                                              controller
                                                  .aboutController.value.text;
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 15.w),
                                          child: Text(AppStrings.save,
                                              style: AppTextStyle
                                                  .repliedUserNameChat()),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 15.w),
                                          child: Text(
                                            AppStrings.cancel,
                                            style: AppTextStyle
                                                .repliedUserNameChat(),
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
                        backgroundColor: ThemeService.isDark.value
                            ? AppColors.snackBarColor
                            : AppColors.grey_350,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Row(
              children: [
                Expanded(child: Icon(Icons.phone)),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.phone,
                        style: AppTextStyle.nameHeading(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          "+917011575173",
                          style: AppTextStyle.chatLabelText(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.dialog(Obx(() => SimpleDialog(
                        title: Text(
                          AppStrings.changeTheme,
                          textAlign: TextAlign.center,
                        ),
                        titleTextStyle: AppTextStyle.chatLabelText(),
                        backgroundColor: ThemeService.isDark.value
                            ? AppColors.snackBarColor
                            : Colors.white,
                        children: [
                          ListTile(
                            leading: Radio(
                                activeColor: Get.theme.primaryColor,
                                value: 0,
                                groupValue: controller.themeButton.value,
                                onChanged: (value) {
                                  controller.themeButton.value = 0;
                                }),
                            horizontalTitleGap: 0,
                            title: Text(AppStrings.systemTheme,
                                style: AppTextStyle.normalText()),
                            onTap: () {
                              controller.themeButton.value = 0;
                            },
                          ),
                          ListTile(
                            leading: Radio(
                                activeColor: Get.theme.primaryColor,
                                value: 1,
                                groupValue: controller.themeButton.value,
                                onChanged: (value) {
                                  controller.themeButton.value = 1;
                                }),
                            horizontalTitleGap: 0,
                            title: Text(
                              AppStrings.darkTheme,
                              style: AppTextStyle.normalText(),
                            ),
                            onTap: () {
                              controller.themeButton.value = 1;
                            },
                          ),
                          ListTile(
                            leading: Radio(
                                activeColor: Get.theme.primaryColor,
                                value: 2,
                                groupValue: controller.themeButton.value,
                                onChanged: (value) {
                                  controller.themeButton.value = 2;
                                }),
                            horizontalTitleGap: 0,
                            title: Text(AppStrings.lightTheme,
                                style: AppTextStyle.normalText()),
                            onTap: () {
                              controller.themeButton.value = 2;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  Get.back();
                                  Future.delayed(
                                      Duration(milliseconds: 100),
                                      () async =>
                                          await controller.changeAppTheme());
                                },
                                child: Text(
                                  AppStrings.save,
                                  style: AppTextStyle.normalText(),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(AppStrings.cancel,
                                    style: AppTextStyle.normalText()),
                              ),
                              SizedBox(
                                width: 10.w,
                              )
                            ],
                          )
                        ],
                      )));
                },
                child: Container(
                  padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                  decoration: BoxDecoration(color: Colors.black12),
                  child: Row(
                    children: [
                      Expanded(child: Icon(Icons.wb_sunny)),
                      Expanded(
                        flex: 3,
                        child: Text(
                          AppStrings.changeTheme,
                          style: AppTextStyle.chatLabelText(),
                        ),
                      ),
                      Expanded(
                        child: Container(),
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
                onTap: () {
                  AppDialogBox.showDialog(
                    AppStrings.areYouSureDeleteAccount,
                    title: "",
                    onTapYes: () {
                      SecureUserModel().deleteUserSessionSecure(
                        AppStrings.screenPin,
                      );
                      AppGetStorage.clearStorage();
                      Get.back();
                    },
                    onTapNo: () {},
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                  decoration: BoxDecoration(color: Colors.black12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.delete_forever_outlined,
                          color: AppColors.appColor,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          AppStrings.delete,
                          style: AppTextStyle.chatLabelText().copyWith(
                            color: AppColors.appColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
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
                onTap: () {
                  AppDialogBox.showDialog(
                    AppStrings.areYouSureLogout,
                    title: "",
                    onTapYes: () {
                      SecureUserModel().deleteUserSessionSecure(
                        AppStrings.screenPin,
                      );
                      AppGetStorage.clearStorage();
                      Get.back();
                    },
                    onTapNo: () {},
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                  decoration: BoxDecoration(color: Colors.black12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Icon(
                          Icons.logout_outlined,
                          color: AppColors.appColor,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          AppStrings.logout,
                          style: AppTextStyle.chatLabelText().copyWith(
                            color: AppColors.appColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
