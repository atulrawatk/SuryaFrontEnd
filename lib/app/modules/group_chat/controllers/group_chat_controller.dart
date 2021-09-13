import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:surya/app/data/models/chat_user_model.dart';
import 'package:surya/app/data/models/my_chat_user_model.dart';
import 'package:surya/app/data/record_sound.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/modules/chat_media/controllers/chat_media_controller.dart';
import 'package:surya/app/modules/home/controllers/home_controller.dart';
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

  RxList<MessageDBList> selectedMessages = <MessageDBList>[].obs;
  Rx<MessageDBList> replyMessage = MessageDBList(
      name: "",
      isGroup: true,
      isMe: false,
      message: "",
      messageType: MessageType.text,
      time: "",
      messageSeen: "",
      repliedMessage: null,
      isSelected: false.obs,
      media: "",
      mediaType: MediaType.none,
      isTapped: false.obs)
      .obs;

  focusNodeListen() {
    messageFocusField.addListener(() {
      if (messageFocusField.hasFocus) {
        emojiOpen.value = false;
        scrollController.jumpTo(scrollController.position.minScrollExtent);
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
  storingMessageInDb(){
    //Adding messages into User List which is fetched at Home Screen
    HomeController homeController=Get.find<HomeController>();
    if(homeController.userList.contains(groupModel)){
      homeController.userList.remove(groupModel);
    }
    homeController.userList.add(groupModel);

    //Storing Messages in Local Db into Storage
    AppGetStorage.storage.write(AppStrings.userList, homeController.userList.value);
    Logger().wtf(AppGetStorage.getValue(AppStrings.userList));
  }

  sendMessage() {
    if (textEditingController.text.length > 0) {
      groupModel.messageList!.add(MessageDBList(
          name: "You",
          isGroup: true,
          isMe: true,
          message: textEditingController.text,
          messageType: MessageType.text,
          time: DateTime.now().toUtc().toString(),
          messageSeen: "seen",
          repliedMessage: replyMsg.value ? replyMessage.value : null,
          isSelected: false.obs,
          media: "",
          mediaType: MediaType.none,
          isTapped: false.obs));
      storingMessageInDb();
      replyMsg.value = false;
      emojiOpen.value = false;
      textEditingController.clear();
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    }
  }
  late ChatMediaController mediaController;
  late ChatUserDBModel groupModel;
  @override
  void onInit() {
    super.onInit();
    sendStatusCheck();
    focusNodeListen();
    recordSound = RecordSound();
    player = AudioPlayer();
    animationInitializer();
    mediaController=Get.put(ChatMediaController());
    getGroupModel();
  }

  getGroupModel(){
    groupModel=Get.arguments;
  }

  sendStatusCheck() {
    textEditingController.addListener(() {
      if (textEditingController.text.trim().isNotEmpty) {
        sendStatus.value = true;
        scrollController.jumpTo(scrollController.position.minScrollExtent);
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
          groupModel.messageList!.add(MessageDBList(
              name: "You",
              isGroup: true,
              isMe: true,
              message: "",
              messageType: MessageType.media,
              time: DateTime.now().toUtc().toString(),
              messageSeen: "seen",
              repliedMessage: replyMsg.value ? replyMessage.value : null,
              isSelected: false.obs,
              media: audioPath,
              mediaType: MediaType.audio,
              isTapped: false.obs));
          storingMessageInDb();
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
      if (groupModel.messageList!.contains(element)) {
        groupModel.messageList!.remove(element);
        return true;
      } else {
        return false;
      }
    });
    if(groupModel.messageList!.length<=0){
      HomeController homeController=Get.find<HomeController>();
      homeController.userList.remove(groupModel);
      AppGetStorage.storage.write(AppStrings.userList, homeController.userList);
    }
    print(groupModel.messageList!.length);
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
            groupModel.messageList!.add(MessageDBList(
                name: "You",
                isGroup: true,
                isMe: true,
                message: "",
                messageType: MessageType.media,
                time: DateTime.now().toUtc().toString(),
                messageSeen: AppStrings.smallSeen,
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: value!.paths.first!,
                mediaType: MediaType.video,
                isTapped: false.obs));
            //mediaController.videoController=VideoPlayerController.file(File(value.paths.first!))..initialize();
            break;
          case MediaType.audio:
            groupModel.messageList!.add(MessageDBList(
                name: "You",
                isGroup: true,
                isMe: true,
                message: "",
                messageType: MessageType.media,
                time: DateTime.now().toUtc().toString(),
                messageSeen: AppStrings.smallSeen,
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: value!.paths.first!,
                mediaType: MediaType.audio,
                isTapped: false.obs));
            break;
          case MediaType.image:
            groupModel.messageList!.add(MessageDBList(
                name: "You",
                isGroup: true,
                isMe: true,
                message: "",
                messageType: MessageType.media,
                time: DateTime.now().toUtc().toString(),
                messageSeen: AppStrings.smallSeen,
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: value!.paths.first!,
                mediaType: MediaType.image,
                isTapped: false.obs));
            break;
          default:
            groupModel.messageList!.add(MessageDBList(
                name: "You",
                isGroup: true,
                isMe: true,
                message: "",
                messageType: MessageType.media,
                time: DateTime.now().toUtc().toString(),
                messageSeen: AppStrings.smallSeen,
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: value!.paths.first!,
                mediaType: MediaType.document,
                isTapped: false.obs));
        }
        Get.back();
        storingMessageInDb();
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      }).catchError((error) {
        Logger().w(error.toString());
      });
    } catch (e) {
      Get.snackbar(AppStrings.appName, e.toString());
      Get.back();
    }
  }
  String? returnReplyMessage(){
    if(replyMessage.value.messageType=="media"){
      switch(replyMessage.value.mediaType){
        case "video":
          return AppStrings.video;
        case "image":
          return AppStrings.image;
        case "document":
          return AppStrings.document;
        case "audio":
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
   Get.toNamed(Routes.GROUP_PROFILE,arguments: groupModel);
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
      scrollController.jumpTo(scrollController.position.minScrollExtent);
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
