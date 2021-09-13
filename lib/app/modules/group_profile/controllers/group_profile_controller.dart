import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/data/models/my_chat_user_model.dart';

class GroupProfileController extends GetxController {
  late ChatUserDBModel groupModel;
  RxBool _checkBox = RxBool(true);
  bool get checkBox => this._checkBox.value;
  set checkBox(bool v) => this._checkBox.value = v;

  TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    groupModel=Get.arguments;
    groupModel.messageList!.forEach((element) {
      if(element.messageType=="media"){
        _mediaMessages.add(element);
      }
    });
  }
  RxList<MessageDBList> _mediaMessages=<MessageDBList>[].obs;

  List<MessageDBList> get mediaMessages=>_mediaMessages.value;

  set mediaMessages(List<MessageDBList> list){

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _mediaMessages.clear();
  }
}
