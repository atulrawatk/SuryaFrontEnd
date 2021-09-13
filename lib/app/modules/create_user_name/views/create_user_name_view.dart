import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/global_widgets/user_image_edit_menu.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/app_text_style.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/theme_service.dart';
import 'package:surya/app/utils/utils.dart';

import '../controllers/create_user_name_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateUserNameView extends GetView<CreateUserNameController> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: controller.formKey,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.createUserName,
                style: AppTextStyle.mainPageHeading(),
              ),
            ),
            body: ListView(
              padding: EdgeInsets.only(top: 20.h),
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Obx(() => Container(
                            height: 150.h,
                            width: 150.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              image: DecorationImage(
                                  image: !controller.setProfileImage.value ||
                                          controller.profileImage.value == ""
                                      ? Image.asset(AppImages.dummyProfileImage)
                                          .image
                                      : Image.file(File(
                                              controller.profileImage.value))
                                          .image,
                                  fit: BoxFit.cover),
                            ),
                          )),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                            controller.profileImage.value = "";
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
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
                  child: Center(
                    child: TextFormWidget(
                        textEditingController: controller.nameController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.name,
                        hintText: AppStrings.name,
                        maxLength: 10,
                        validator: Validators.name,
                        formatter: []),
                  ),
                ),
                Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 100.h),
                  width: 100.w,
                  height: 40.h,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.toHomePage();
                      },
                      child: Text(
                        AppStrings.save,
                        style: AppTextStyle.normalText(),
                      )),
                ))
              ],
            )));
  }
}
