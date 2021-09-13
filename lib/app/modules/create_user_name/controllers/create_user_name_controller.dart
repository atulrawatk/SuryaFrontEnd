import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surya/app/data/models/personal_user_details_model.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/strings.dart';

class CreateUserNameController extends GetxController {
  //TODO: Implement CreateUserNameController

  final count = 0.obs;
  RxString profileImage = "".obs;
  RxBool setProfileImage = false.obs;
  late TextEditingController nameController;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

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
        profileImage.value = value!.paths.first!;
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
        profileImage.value = value!.path;
      });
    }
  }

  toHomePage() {
    if (formKey.currentState!.validate()) {
      PersonalUserDetailsModel personalData = PersonalUserDetailsModel(
        name: nameController.text.obs,
        profileImage: profileImage.value.obs,
        about:AppStrings.busy.obs
      );
      AppGetStorage.storage.write(AppStrings.userDetails, personalData);
      AppGetStorage.saveValue(AppStrings.isLogin, true);
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onInit() {
    super.onInit();
    nameController = new TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
