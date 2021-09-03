import 'dart:io';

import 'package:get/get.dart';
import 'package:surya/app/utils/utils.dart';

class ChatMessageModel {
  bool isMe;
  bool isGroup;
  RxBool isSelected;
  String name;
  String message;
  MessageType messageType;
  String time;
  String messageSeen;
  MediaType mediaType;
  File media;
  RxBool isTapped;
  ChatMessageModel? repliedMessage;
  ChatMessageModel(
      {required this.name,
      required this.isGroup,
      required this.isMe,
      required this.message,
      required this.messageType,
      required this.time,
      required this.messageSeen,
       this.repliedMessage,
        required this.isSelected,
        required this.media,
        required this.mediaType,
        required this.isTapped
      });

}
