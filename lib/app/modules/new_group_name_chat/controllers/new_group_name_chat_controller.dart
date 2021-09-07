import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surya/app/data/models/ContactUsers.dart';
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:surya/app/data/models/chat_user_model.dart';
import 'package:surya/app/routes/app_pages.dart';

class NewGroupNameChatController extends GetxController {
  late TextEditingController groupNameController;
  RxMap<String,ContactUsers> groupContactList=<String,ContactUsers>{}.obs;
  RxList<ContactUsers> contactUsers=List<ContactUsers>.empty(growable: true).obs;
  GlobalKey<FormState> key=new GlobalKey<FormState>();
  RxBool setProfileImage = false.obs;
  Rx<File> profileImage = File("").obs;

  @override
  void onInit() {
    super.onInit();
    groupNameController=new TextEditingController();
    groupContactList.addAll(Get.arguments);
    groupContactList.forEach((key, value) {
      contactUsers.add(value);
    });
  }

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

  toGroupChat(){
    if (key.currentState!.validate()) {
      List<ChatUserModel> groupUsers =
      List.empty(growable: true);
      contactUsers.forEach((element) {
        groupUsers.add( ChatUserModel(
            name: element.name.obs,
            number: element.number.toString(),
            isGroup: true,
            users: <ChatUserModel>[].obs,
            profileImage: File("").obs,
            isBlocked: false.obs,
            messageList: <ChatMessageModel>[].obs));
      });
      Get.toNamed(Routes.GROUP_CHAT,
          arguments:
          // {
          //   AppStrings.groupNameSmall:
          //       controller.groupNameController.text,
          //   AppStrings.groupListSmall:
          //       controller.contactUsers.value
          // }
          ChatUserModel(
              name:
              groupNameController.text.obs,
              number: "",
              isGroup: true,
              users: groupUsers.obs,
              profileImage: profileImage,
              isBlocked: false.obs,
              messageList: <ChatMessageModel>[].obs));
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
