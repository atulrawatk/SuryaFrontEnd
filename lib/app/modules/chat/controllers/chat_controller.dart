import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surya/app/data/models/chat_message_model.dart';

class ChatController extends GetxController {
  RxBool sendStatus = false.obs;
  ScrollController scrollController = new ScrollController();
  TextEditingController textEditingController = new TextEditingController();
  var textFieldHeight = 45.h.obs;
  FocusNode messageFocusField = new FocusNode();
  var replyMsg = false.obs;

  RxBool emojiOpen = false.obs;
  Rx<ChatMessageModel> replyMessage = ChatMessageModel(
          name: "",
          isGroup: false,
          isMe: false,
          message: "",
          messageType: "",
          time: "",
          messageSeen: "",
          repliedMessage: null)
      .obs;

  focusNodeListen() {
    messageFocusField.addListener(() {
      if (messageFocusField.hasFocus) {
        emojiOpen.value = false;
        scrollController.position
            .forcePixels(scrollController.position.maxScrollExtent + 55.h);
      }
    });
  }

  RxList<ChatMessageModel> oneToOneChatModel = [
    ChatMessageModel(
        name: "",
        isGroup: false,
        isMe: true,
        message: "Hi",
        messageType: "text",
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null),
    ChatMessageModel(
        name: "Harish",
        isGroup: false,
        isMe: false,
        message: "Hello",
        messageType: "text",
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null),
    ChatMessageModel(
        name: "",
        isGroup: false,
        isMe: true,
        message: "How are you?",
        messageType: "text",
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null),
    ChatMessageModel(
        name: "Harish",
        isGroup: false,
        isMe: false,
        message:
            "I'm good and you? ewjfghewukhfe iuwbfuwehfhbgwe ufwuefuwehfu wehfuehwfiu hewufhewof hiowehfiowehfih wehofiewbfw",
        messageType: "text",
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null),
    ChatMessageModel(
        name: "",
        isGroup: false,
        isMe: true,
        message: "Me too!!",
        messageType: "text",
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null)
  ].toList(growable: true).obs;

  sendMessage() {
    if (textEditingController.text.length > 0) {
      oneToOneChatModel.add(ChatMessageModel(
          name: "",
          isGroup: false,
          isMe: true,
          message: textEditingController.text,
          messageType: "text",
          time: TimeOfDay.hoursPerDay.toString(),
          messageSeen: "seen",
          repliedMessage: replyMsg.value ? replyMessage.value : null));
      replyMsg.value = false;
      emojiOpen.value = false;
      textEditingController.clear();
      scrollController.position
          .forcePixels(scrollController.position.maxScrollExtent + 55.h);
    }
  }

  @override
  void onInit() {
    super.onInit();
    sendStatusCheck();
    focusNodeListen();
  }

  sendStatusCheck() {
    textEditingController.addListener(() {
      if (textEditingController.text.trim().isNotEmpty) {
        sendStatus.value = true;
        scrollController.position
            .forcePixels(scrollController.position.maxScrollExtent);
      } else {
        sendStatus.value = false;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
