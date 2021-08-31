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
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:surya/app/data/record_sound.dart';
import 'package:surya/app/modules/chat_media/controllers/chat_media_controller.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:video_player/video_player.dart';


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

  RxList<ChatMessageModel> selectedMessages = <ChatMessageModel>[].obs;
  Rx<ChatMessageModel> replyMessage = ChatMessageModel(
          name: "",
          isGroup: false,
          isMe: false,
          message: "",
          messageType: "",
          time: "",
          messageSeen: "",
          repliedMessage: null,
          isSelected: false.obs,
          media: File(""),
          mediaType: "",
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

  animationInitilizer() {
    animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    myAnimation = CurvedAnimation(curve: Curves.linear, parent: animController);
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
        repliedMessage: null,
        isSelected: false.obs,
        media: File(""),
        mediaType: "",
        isTapped: false.obs),
    ChatMessageModel(
        name: "Harish",
        isGroup: false,
        isMe: false,
        message: "Hello",
        messageType: "text",
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null,
        isSelected: false.obs,
        media: File(""),
        mediaType: "",
        isTapped: false.obs),
    ChatMessageModel(
        name: "",
        isGroup: false,
        isMe: true,
        message: "How are you?",
        messageType: "text",
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null,
        isSelected: false.obs,
        media: File(""),
        mediaType: "",
        isTapped: false.obs),
    ChatMessageModel(
        name: "Harish",
        isGroup: false,
        isMe: false,
        message:
            "I'm good and you? ewjfghewukhfe iuwbfuwehfhbgwe ufwuefuwehfu wehfuehwfiu hewufhewof hiowehfiowehfih wehofiewbfw",
        messageType: "text",
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null,
        isSelected: false.obs,
        media: File(""),
        mediaType: "",
        isTapped: false.obs),
    ChatMessageModel(
        name: "",
        isGroup: false,
        isMe: true,
        message: "Me too!!",
        messageType: "text",
        time: "18:00:00 03-08-2021",
        messageSeen: "seen",
        repliedMessage: null,
        isSelected: false.obs,
        media: File(""),
        mediaType: "",
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
          isGroup: false,
          isMe: true,
          message: textEditingController.text,
          messageType: "text",
          time: TimeOfDay.now().toString(),
          messageSeen: "seen",
          repliedMessage: replyMsg.value ? replyMessage.value : null,
          isSelected: false.obs,
          media: File(""),
          mediaType: "",
          isTapped: false.obs));
      replyMsg.value = false;
      emojiOpen.value = false;
      textEditingController.clear();
      scrollController.position
          .forcePixels(scrollController.position.maxScrollExtent + 55.h);
    }
  }
  late ChatMediaController mediaController;
  @override
  void onInit() {
    super.onInit();
    sendStatusCheck();
    focusNodeListen();
    recordSound = RecordSound();
    player = AudioPlayer();
    animationInitilizer();
     mediaController=Get.put(ChatMediaController());
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
              isGroup: false,
              isMe: true,
              message: "",
              messageType: "media",
              time: TimeOfDay.now().toString(),
              messageSeen: "seen",
              repliedMessage: replyMsg.value ? replyMessage.value : null,
              isSelected: false.obs,
              media: File(audioPath),
              mediaType: "audio",
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

  Future attachFile({required String file}) async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(
              type: file == AppStrings.audioSmall
                  ? FileType.audio
                  : file == AppStrings.videoSmall
                      ? FileType.video
                      : file == AppStrings.imageSmall
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
          case AppStrings.videoSmall:
            oneToOneChatModel.add(ChatMessageModel(
                name: "You",
                isGroup: false,
                isMe: true,
                message: "",
                messageType: "media",
                time: TimeOfDay.now().toString(),
                messageSeen: "seen",
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: File(value!.paths.first!),
                mediaType: AppStrings.videoSmall,
                isTapped: false.obs));
            //mediaController.videoController=VideoPlayerController.file(File(value.paths.first!))..initialize();
            break;
          case AppStrings.audioSmall:
            oneToOneChatModel.add(ChatMessageModel(
                name: "You",
                isGroup: false,
                isMe: true,
                message: "",
                messageType: "media",
                time: TimeOfDay.now().toString(),
                messageSeen: "seen",
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: File(value!.paths.first!),
                mediaType: AppStrings.audioSmall,
                isTapped: false.obs));
            break;
          case AppStrings.imageSmall:
            oneToOneChatModel.add(ChatMessageModel(
                name: "You",
                isGroup: false,
                isMe: true,
                message: "",
                messageType: "media",
                time: DateTime.now().toUtc().toString(),
                messageSeen: "seen",
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: File(value!.paths.first!),
                mediaType: AppStrings.imageSmall,
                isTapped: false.obs));
            break;
          default:
            oneToOneChatModel.add(ChatMessageModel(
                name: "You",
                isGroup: false,
                isMe: true,
                message: "",
                messageType: "media",
                time: TimeOfDay.now().toString(),
                messageSeen: "seen",
                repliedMessage: replyMsg.value ? replyMessage.value : null,
                isSelected: false.obs,
                media: File(value!.paths.first!),
                mediaType: AppStrings.documentSmall,
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
