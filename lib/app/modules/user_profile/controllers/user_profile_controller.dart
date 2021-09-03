import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/theme_service.dart';

class UserProfileController extends GetxController {
  final count = 0.obs;
  RxBool themeSwitch = false.obs;
  RxInt themeButton = 0.obs;

  Rx<TextEditingController> aboutController =
      new TextEditingController(text: AppStrings.busy).obs;
  Rx<TextEditingController> nameController =
      new TextEditingController(text: "Sangam").obs;

  RxString aboutString = AppStrings.busy.obs;
  RxString nameString = "Sangam".obs;

  FocusNode aboutFocusNode = new FocusNode();
  FocusNode nameFocusNode = new FocusNode();
  @override
  void onInit() {
    super.onInit();
    getUserTheme();
  }

  getUserTheme() {
    if (AppGetStorage.storage.hasData(AppStrings.appTheme)) {
      String storedTheme = AppGetStorage.storage.read(AppStrings.appTheme);
      switch (storedTheme) {
        case AppStrings.smallLightTheme:
          themeButton.value = 2;
          break;
        case AppStrings.smallDarkTheme:
          themeButton.value = 1;
          break;
        case AppStrings.smallSystemTheme:
          themeButton.value = 0;
          break;
      }
    } else {
      themeButton.value = 0;
    }
  }

  Rx<File> profileImage = File("").obs;
  RxBool setProfileImage = false.obs;
  Future imagePicker(ImageSource imageSource) async {
    if (imageSource == ImageSource.gallery) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(
        type: FileType.image,
        allowCompression: true,
        allowMultiple: false,
        withData: true,
        //allowedExtensions: ['jpg', 'jpeg', 'gif', "png", "raw", "eps", "svg"],
      )
          .then((value) {
        setProfileImage.value = true;
        profileImage.value = File(value!.paths.first!);
      });
      //  (result!.paths.first!);
    } else if (imageSource == ImageSource.camera) {
      PickedFile? image = await ImagePicker()
          .getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 500,
        maxHeight: 500,
      )
          .then((value) {
        setProfileImage.value = true;
        profileImage.value = File(value!.path);
      });
    }
  }

  Future changeAppTheme() async {
    switch (themeButton.value) {
      case 0:
        Get.changeThemeMode(
            Get.isPlatformDarkMode ? ThemeMode.dark : ThemeMode.light);
        AppGetStorage.storage
            .write(AppStrings.appTheme, AppStrings.smallSystemTheme);
        ThemeService.isDark.value = Get.isPlatformDarkMode ? true : false;
        Logger().i(AppGetStorage.storage.hasData(AppStrings.appTheme));
        Logger().i("Theme is Dark=====>>> ${ThemeService.isDark.value}");
        break;
      case 1:
        Get.changeThemeMode(ThemeMode.dark);
        AppGetStorage.storage
            .write(AppStrings.appTheme, AppStrings.smallDarkTheme);

        ThemeService.isDark.value = true;
        Logger().i(AppGetStorage.storage.hasData(AppStrings.appTheme));
        Logger().i("Theme is Dark=====>>> ${ThemeService.isDark.value}");
        break;
      case 2:
        Get.changeThemeMode(ThemeMode.light);
        AppGetStorage.storage
            .write(AppStrings.appTheme, AppStrings.smallLightTheme);

        ThemeService.isDark.value = false;
        Logger().i(AppGetStorage.storage.hasData(AppStrings.appTheme));
        Logger().i("Theme is Dark=====>>> ${ThemeService.isDark.value}");
        break;
    }
  }

  systemDefaultTheme() {}
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
