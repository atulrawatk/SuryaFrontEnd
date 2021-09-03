import 'dart:io';

import 'package:get/get.dart';
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:surya/app/utils/enum_navigation.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:video_player/video_player.dart';

class ChatMediaController extends GetxController {
  late ChatMessageModel chatModel;
  Rx<VideoPlayerController> videoController=VideoPlayerController.file(File("")).obs;
  RxBool isPlaying=false.obs;
  RxDouble videoTimer=00.00.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  videoListeners(){
    videoController.value.addListener(() {
      videoTimer.value=videoController.value.value.position.inMicroseconds.toDouble();
      if(videoController.value.value.isPlaying){
        isPlaying.value=true;
      }
      else{
        isPlaying.value=false;
      }
    });
  }

  playVideo(){
    if(chatModel.mediaType==MediaType.video){
     // videoController.value=VideoPlayerController.file(chatModel.media)..initialize();
      Future.delayed(Duration(seconds: 0),()=>videoController.value.play());
    }
  }
  stopVideo(){
    if(chatModel.mediaType==MediaType.video){
      videoController.value.dispose();
    }
  }
  pauseVideo(){
    if(chatModel.mediaType==MediaType.video){
      videoController.value.pause();
    }
  }

  @override
  void onClose() {}
}
