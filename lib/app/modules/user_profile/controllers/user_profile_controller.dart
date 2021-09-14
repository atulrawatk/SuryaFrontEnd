import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/data/models/personal_user_details_model.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/theme_service.dart';

class UserProfileController extends GetxController {
  final count = 0.obs;
  RxBool themeSwitch = false.obs;
  RxInt themeButton = 0.obs;

  late Rx<TextEditingController> aboutController;
  late Rx<TextEditingController> nameController;

  RxString aboutString = AppStrings.busy.obs;
  RxString nameString = "".obs;

  FocusNode aboutFocusNode = new FocusNode();
  FocusNode nameFocusNode = new FocusNode();
  late PersonalUserDetailsModel userValues;
  @override
  void onInit() {
    super.onInit();
    getUserTheme();
    getUserValues();
  }

  getUserValues() {
    Logger().v(AppGetStorage.getValue(AppStrings.userDetails));
    PersonalUserDetailsModel model;
    try{
      model = PersonalUserDetailsModel.fromJson(
          AppGetStorage.getValue(AppStrings.userDetails));
    }
    catch(e){
      model=AppGetStorage.getValue(AppStrings.userDetails);
    }
    nameString = model.name!;
    profileImage = model.profileImage!;
    aboutString = model.about!;
    userValues = model;
    listenUserValues();
    aboutController =
        new TextEditingController(text: userValues.about!.value).obs;
    nameController =
        new TextEditingController(text: userValues.name!.value).obs;
  }

  listenUserValues() {
    AppGetStorage.storage.listenKey(AppStrings.userDetails, (value) {
      userValues = value;
      if (userValues.profileImage!.value != "") {
        setProfileImage.value = true;
      } else {
        setProfileImage.value = false;
      }
      profileImage.value = userValues.profileImage!.value;
      aboutString = userValues.about!;
      nameString = userValues.name!;
    });
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

  RxString profileImage = "".obs;
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
        userValues.profileImage!.value = value!.paths.first!;
        AppGetStorage.storage.write(AppStrings.userDetails, userValues);
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
        userValues.profileImage!.value = value!.path;
        AppGetStorage.storage.write(AppStrings.userDetails, userValues);
      });
    }
  }

  setAbout() {
    userValues.about!.value = aboutController.value.text;
    AppGetStorage.storage.write(AppStrings.userDetails, userValues);
  }

  setName() {
    userValues.name!.value = nameController.value.text;
    AppGetStorage.storage.write(AppStrings.userDetails, userValues);
  }

  removeProfilePicture() {
    userValues.profileImage!.value = "";
    AppGetStorage.storage.write(AppStrings.userDetails, userValues);
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
