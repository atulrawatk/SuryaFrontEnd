import 'dart:io';

import 'package:get/get.dart';
import 'package:surya/app/data/models/chat_message_model.dart';

class ChatUserModel {
  RxString name;
  String number;
  bool isGroup;
  RxBool isBlocked;
  RxList<ChatUserModel> users;
  Rx<File> profileImage;
  RxList<ChatMessageModel> messageList;

  ChatUserModel(
      {required this.name,
      required this.number,
      required this.isGroup,
        required this.users,
      required this.profileImage,
      required this.isBlocked,
      required this.messageList});
}
