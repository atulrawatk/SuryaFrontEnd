import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:surya/app/data/models/call_d_b_model.dart';
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:surya/app/data/models/chat_user_model.dart';
import 'package:surya/app/data/models/my_chat_user_model.dart';
import 'package:surya/app/data/record_sound.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/modules/chat_media/controllers/chat_media_controller.dart';
import 'package:surya/app/modules/home/controllers/home_controller.dart';
import 'package:surya/app/modules/other_user_profile/controllers/other_user_profile_controller.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/enum_navigation.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert' as JSON;

class ChatController extends GetxController with SingleGetTickerProviderMixin {
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
          isGroup: false,
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

  otherUserProfile() {
    Get.toNamed(Routes.OTHER_USER_PROFILE, arguments: userModel);
  }

  focusNodeListen() {
    messageFocusField.addListener(() {
      if (messageFocusField.hasFocus) {
        emojiOpen.value = false;
        // scrollController.position
        //     .forcePixels(scrollController.position.maxScrollExtent + 55.h);
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

  sendMessage() {
    if (textEditingController.text.length > 0) {
      userModel.messageList!.add(MessageDBList(
          name: "You",
          isGroup: false,
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
  late ChatUserDBModel userModel;
  @override
  void onInit() {
    super.onInit();
    userModel = Get.arguments;
    sendStatusCheck();
    focusNodeListen();
    recordSound = RecordSound();
    player = AudioPlayer();
    animationInitializer();
    mediaController = Get.put(ChatMediaController());
  }

  sendStatusCheck() {
    textEditingController.addListener(() {
      if (textEditingController.text.trim().isNotEmpty) {
        sendStatus.value = true;
        // scrollController.position
        //     .forcePixels(scrollController.position.maxScrollExtent);
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      } else {
        sendStatus.value = false;
      }
    });
  }

  Future recordMessages() async {
    await recordSound
        .getRecorderFn(
            path: "surya_recording${DateTime.now().toUtc().toString()}.mp4")
        .then((value) {
      if (stopTimer.value) {
        // recordSound.recordedAudioPath="surya_recording${DateTime.now().toIso8601String()}.mp4";
        Future.delayed(Duration(seconds: 1), () {
          String audioPath = recordSound.recordedAudioPath;
          userModel.messageList!.add(MessageDBList(
              name: "You",
              isGroup: false,
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

  storingMessageInDb(){
    //Adding messages into User List which is fetched at Home Screen
    HomeController homeController=Get.find<HomeController>();
    if(homeController.userList.contains(userModel)){
      homeController.userList.remove(userModel);
    }
    homeController.userList.add(userModel);

    //Storing Messages in Local Db into Storage
    AppGetStorage.storage.write(AppStrings.userList, homeController.userList.value);
    Logger().wtf(AppGetStorage.getValue(AppStrings.userList));
  }

  Future playAudio(String path) async {
    //File file = File(path);
    await player.setFilePath(path).whenComplete(() => player.play());
  }

  Future stopAudio() async {
    await player.stop();
  }

  calling(){
    HomeController homeController =Get.find<HomeController>();
    CallDBModel callDBModel=CallDBModel(
      name: userModel.name!.value, time: DateTime.now().toIso8601String().toString(), callType: "called", callTimes: 1.obs,
    );
    List<CallDBModel> callList=List.empty(growable: true);
    callList.addAll(homeController.callLogsList.value);
    callList.add(callDBModel);
    AppGetStorage.storage.write(AppStrings.callLogs,callList);
    // debugPrint(AppGetStorage.getValue(AppStrings.callLogs));
    Get.toNamed(Routes.AUDIO_CALLING,arguments:callDBModel );
  }

  removeMessages() {
    selectedMessages.removeWhere((element) {
      if (userModel.messageList!.contains(element)) {
        userModel.messageList!.remove(element);
        return true;
      } else {
        return false;
      }
    });
    if(userModel.messageList!.length<=0){
      HomeController homeController=Get.find<HomeController>();
      homeController.userList.remove(userModel);
      AppGetStorage.storage.write(AppStrings.userList, homeController.userList);
    }
    print(userModel.messageList!.length);
    print(selectedMessages.length);
  }

  Future attachFile({required MediaType file}) async {
    try {
       await FilePicker.platform
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
            userModel.messageList!.add(MessageDBList(
                name: "You",
                isGroup: false,
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
            break;
          case MediaType.audio:
            userModel.messageList!.add(MessageDBList(
                name: "You",
                isGroup: false,
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
            userModel.messageList!.add(MessageDBList(
                name: "You",
                isGroup: false,
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
            userModel.messageList!.add(MessageDBList(
                name: "You",
                isGroup: false,
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

  String? returnReplyMessage() {
    if (replyMessage.value.messageType == "media") {
      switch (replyMessage.value.mediaType) {
        case "video":
          return AppStrings.video;
        case "image":
          return AppStrings.image;
        case "document":
          return AppStrings.document;
        case "audio":
          return AppStrings.audio;
        default:
          return AppStrings.document;
      }
    } else {
      return replyMessage.value.message;
    }
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
