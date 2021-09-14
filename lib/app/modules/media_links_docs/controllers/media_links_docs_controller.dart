import 'dart:io';

import 'package:get/get.dart';
import 'package:surya/app/data/models/my_chat_user_model.dart';
import 'package:surya/app/modules/chat/controllers/chat_controller.dart';
import 'package:surya/app/modules/group_chat/controllers/group_chat_controller.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:video_player/video_player.dart';

class MediaLinksDocsController extends GetxController {
  //TODO: Implement MediaLinksDocsController
  late ChatUserDBModel model;
  late RxList<MessageDBList> mediaMessages=<MessageDBList>[].obs;
  @override
  void onInit() {
    super.onInit();
    getChatValues();
  }

  getChatValues(){
    model=Get.arguments;
    model.messageList!.forEach((element) {
      if(element.messageType=="media") {
        mediaMessages.add(element);
      }
    });
  }


  openMedia(int index){
    dynamic gcController;
    if(model.isGroup!){
      gcController=Get.find<GroupChatController>();
    }
    else{
      gcController =
          Get.find<ChatController>();
    }
    if (mediaMessages[index].mediaType ==
        "video") {
      gcController.mediaController.videoController.value =
      VideoPlayerController.file(
          File(mediaMessages[index].media!))
        ..initialize().whenComplete(() {
          Future.delayed(Duration.zero,
                  () => Get.toNamed(Routes.CHAT_MEDIA));
          gcController.mediaController.videoListeners();
        });
      gcController.mediaController.chatModel =
      mediaMessages[index];
    } else if (mediaMessages[index].mediaType ==
        "image") {
      Future.delayed(
          Duration.zero,
              () => Get.toNamed(Routes.CHAT_MEDIA,
              arguments:mediaMessages[index]));
      gcController.mediaController.chatModel =
    mediaMessages[index];
    }
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
