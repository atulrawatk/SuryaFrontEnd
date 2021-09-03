import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:surya/app/data/record_sound.dart';
import 'package:surya/app/modules/chat_media/controllers/chat_media_controller.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/enum_navigation.dart';
import 'package:surya/app/utils/strings.dart';

class GroupChatController extends GetxController with SingleGetTickerProviderMixin{
  RxBool sendStatus = false.obs;
  ScrollController scrollController = new ScrollController();
  TextEditingController textEditingController = new TextEditingController();
  late AudioPlayer player;
  var textFieldHeight = 45.h.obs;
  FocusNode messageFocusField = new FocusNode();
  var replyMsg = false.obs;
  var selectMsg = false.obs;
  RxBool emojiOpen = false.obs;
  RxString filePlayer = "".obs;

  RxBool isPlaying = false.obs;

  late Animation<double> myAnimation;
  late AnimationController animController;

  //Recorder Instances
  late RecordSound recordSound;
  RxString recordingTimer = "".obs;
  RxInt _timer = 0.obs;
  int get timer => _timer.value;
  set setTimer(int value) {
    _timer.value = value;
  }

  RxInt timerMin = 0.obs;
  RxBool isRecording = false.obs;
  RxBool stopTimer = false.obs;

  RxList<ChatMessageModel> selectedMessages = <ChatMessageModel>[].obs;
  Rx<ChatMessageModel> replyMessage = ChatMessageModel(
      name: "",
      isGroup: true,
      isMe: false,
      message: "",
      messageType: MessageType.text,
      time: "",
      messageSeen: "",
      repliedMessage: null,
      isSelected: false.obs,
      media: File(""),
      mediaType: MediaType.none,
      isTapped: false.obs)
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

  animationInitializer() {
    animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    myAnimation = CurvedAnimation(curve: Curves.linear, parent: animController);
  }

  RxList<ChatMessageModel> oneToOneChatModel = [
    ChatMessageModel(
        name: "",
        isGroup: true,
        isMe: true,
        message: "Hi",
        messageType: MessageType.text,
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null,
        isSelected: false.obs,
        media: File(""),
        mediaType: MediaType.none,
        isTapped: false.obs),
    ChatMessageModel(
        name: "Harish",
        isGroup: true,
        isMe: false,
        message: "Hello",
        messageType: MessageType.text,
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null,
        isSelected: false.obs,
        media: File(""),
        mediaType: MediaType.none,
        isTapped: false.obs),
    ChatMessageModel(
        name: "",
        isGroup: true,
        isMe: true,
        message:"How are you?",
        messageType: MessageType.text,
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null,
        isSelected: false.obs,
        media: File(""),
        mediaType: MediaType.none,
        isTapped: false.obs),
    ChatMessageModel(
        name: "Harish",
        isGroup: true,
        isMe: false,
        message:
        "I'm good and you? ewjfghewukhfe iuwbfuwehfhbgwe ufwuefuwehfu wehfuehwfiu hewufhewof hiowehfiowehfih wehofiewbfw",
        messageType: MessageType.text,
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null,
        isSelected: false.obs,
        media: File(""),
        mediaType: MediaType.none,
        isTapped: false.obs),
    ChatMessageModel(
        name: "",
        isGroup: true,
        isMe: true,
        message: "Me too!!",
        messageType: MessageType.text,
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null,
        isSelected: false.obs,
        media: File(""),
        mediaType: MediaType.none,
        isTapped: false.obs)
  ].toList(growable: true).obs;

  timerStart() {
    if (stopTimer.value) {
      setTimer = 0;
      timerMin.value = 0;
      return;
    }
    Timer(Duration(seconds: 1), () {
      setTimer = timer + 1;
      timerStart();
    });
  }

  String recordingMessageTimer() {
    if (timer < 10) {
      return " 0${timerMin.value}:0" + timer.toString();
    } else if (timer >= 10 && timer < 60) {
      return " 0${timerMin.value}:" + timer.toString();
    } else {
      if (timer == 60) {
        setTimer = 0;
        timerMin.value++;
      }
      return " 0${timerMin.value}:0" + timer.toString();
    }
  }

  sendMessage() {
    if (textEditingController.text.length > 0) {
      oneToOneChatModel.add(ChatMessageModel(
          name: "You",
          isGroup: true,
          isMe: true,
          message: textEditingController.text,
          messageType: MessageType.text,
          time: TimeOfDay.now().toString(),
          messageSeen: "seen",
          repliedMessage: replyMsg.value ? replyMessage.value : null,
          isSelected: false.obs,
          media: File(""),
          mediaType: MediaType.none,
          isTapped: false.obs));
      replyMsg.value = false;
      emojiOpen.value = false;
      textEditingController.clear();
      scrollController.position
          .forcePixels(scrollController.position.maxScrollExtent + 55.h);
    }
  }
  late ChatMediaController mediaController;
  RxMap<String,Object> groupArguments=<String,Object>{}.obs;
  RxString groupName="".obs;
  @override
  void onInit() {
    super.onInit();
    sendStatusCheck();
    focusNodeListen();
    recordSound = RecordSound();
    player = AudioPlayer();
    animationInitializer();
    mediaController=Get.put(ChatMediaController());
    groupName.value=Get.arguments.values.first;
    groupArguments.addAll(Get.arguments);
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

  Future recordMessages() async {
    await recordSound.getRecorderFn(path: "surya_recording${DateTime.now().toIso8601String()}.mp4").then((value) {
      if(stopTimer.value){
        // recordSound.recordedAudioPath="surya_recording${DateTime.now().toIso8601String()}.mp4";
        Future.delayed(Duration(seconds: 1),(){
          String audioPath=recordSound.recordedAudioPath;
          oneToOneChatModel.add(ChatMessageModel(
              name: "You",
              isGroup: true,
              isMe: true,
              message: "",
              messageType: MessageType.media,
              time: TimeOfDay.now().toString(),
              messageSeen: "seen",
              repliedMessage: replyMsg.value ? replyMessage.value : null,
              isSelected: false.obs,
              media: File(audioPath),
              mediaType: MediaType.audio,
              isTapped: false.obs));
        });
      }
    });
  }

  Future playAudio(String path) async {
    //File file = File(path);
    await player
        .setFilePath(path)
        .whenComplete(() => player.play());
  }

  Future stopAudio() async {
    await player.stop();
  }

  removeMessages() {
    selectedMessages.removeWhere((element) {
      if (oneToOneChatModel.contains(element)) {
        oneToOneChatModel.remove(element);
        return true;
      } else {
        return false;
      }
    });
    print(oneToOneChatModel.length);
    print(selectedMessages.length);
  }

  Future attachFile({required MediaType file}) async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(
          type: file == MediaType.audio
              ? FileType.audio
              : file == MediaType.video
              ? FileType.video
              : file == MediaType.image
              ? FileType.image
              : FileType.any,
          allowCompression: true,
          allowMultiple: false,
          withData: false,
          onFileLoading: (file) {}
        //allowedExtensions: ['jpg', 'jpeg', 'gif', "png", "raw", "eps", "svg"],
      )
          .then((value) {
        switch (file) {
          case MediaType.video:
            oneToOneChatModel.add(ChatMessageModel(
                name: "You",
                isGroup: true,
                isMe: true,
                message: "",
                messageType: MessageType.media,
                time: DateTime.now().toUtc().toString(),
                messageSeen: AppStrings.smallSeen,
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: File(value!.paths.first!),
                mediaType: MediaType.video,
                isTapped: false.obs));
            //mediaController.videoController=VideoPlayerController.file(File(value.paths.first!))..initialize();
            break;
          case MediaType.audio:
            oneToOneChatModel.add(ChatMessageModel(
                name: "You",
                isGroup: true,
                isMe: true,
                message: "",
                messageType: MessageType.media,
                time: DateTime.now().toUtc().toString(),
                messageSeen: AppStrings.smallSeen,
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: File(value!.paths.first!),
                mediaType: MediaType.audio,
                isTapped: false.obs));
            break;
          case MediaType.image:
            oneToOneChatModel.add(ChatMessageModel(
                name: "You",
                isGroup: true,
                isMe: true,
                message: "",
                messageType: MessageType.media,
                time: DateTime.now().toUtc().toString(),
                messageSeen: AppStrings.smallSeen,
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: File(value!.paths.first!),
                mediaType: MediaType.image,
                isTapped: false.obs));
            break;
          default:
            oneToOneChatModel.add(ChatMessageModel(
                name: "You",
                isGroup: true,
                isMe: true,
                message: "",
                messageType: MessageType.media,
                time: DateTime.now().toUtc().toString(),
                messageSeen: AppStrings.smallSeen,
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: File(value!.paths.first!),
                mediaType: MediaType.document,
                isTapped: false.obs));
        }
        Get.back();
        scrollController.position
            .forcePixels(scrollController.position.maxScrollExtent + 200.h);
      }).catchError((error) {
        Logger().w(error.toString());
      });
    } catch (e) {
      Get.snackbar(AppStrings.appName, e.toString());
      Get.back();
    }
  }
  String returnReplyMessage(){
    if(replyMessage.value.messageType==MessageType.media){
      switch(replyMessage.value.mediaType){
        case MediaType.video:
          return AppStrings.video;
        case MediaType.image:
          return AppStrings.image;
        case MediaType.document:
          return AppStrings.document;
        case MediaType.audio:
          return AppStrings.audio;
        default: return AppStrings.document;
      }
    }
    else{

      return replyMessage
          .value
          .message;
    }
  }

  toOtherUserProfile(){
   Get.toNamed(Routes.GROUP_PROFILE,arguments: oneToOneChatModel);
  }

  Future startRecording() async {
    if (!sendStatus.value) {
      stopTimer.value = false;
      await recordMessages();
      timerStart();
      isRecording.value = true;
    }
  }

  Future stopRecording() async {
    if (!sendStatus.value) {
      stopTimer.value = true;
      await recordMessages();
      isRecording.value = false;
      scrollController.position
          .forcePixels(scrollController.position.maxScrollExtent + 115.h);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    recordSound.closeRecord();
    stopAudio();
  }
}
