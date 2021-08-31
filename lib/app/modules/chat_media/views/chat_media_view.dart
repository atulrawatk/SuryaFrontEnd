import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:video_player/video_player.dart';

import '../controllers/chat_media_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMediaView extends GetView<ChatMediaController> {
  @override
  Widget build(BuildContext context) {
    controller.playVideo();
    return WillPopScope(
      onWillPop: () async {
        controller.pauseVideo();
        return true;
      },
      child: Scaffold(
          body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: controller.chatModel.time,
                child: controller.chatModel.mediaType == AppStrings.imageSmall
                    ? Container(
                          height: Get.height*0.8,
                        width: Get.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(controller.chatModel.media),
                                fit: BoxFit.fitHeight),
                            borderRadius: BorderRadius.circular(10.r)),
                      )
                    : controller.chatModel.mediaType == AppStrings.videoSmall
                        ? controller.videoController.value.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: controller
                                    .videoController.value.value.aspectRatio,
                                child: GestureDetector(
                                    onTap: () {
                                      controller.videoController.value.value
                                              .isPlaying
                                          ? controller.videoController.value
                                              .pause()
                                          : controller.videoController.value
                                              .play();
                                    },
                                    child: VideoPlayer(
                                        controller.videoController.value)),
                              )
                            : Container()
                        : SizedBox(),
              ),
            ),
            controller.chatModel.mediaType == AppStrings.videoSmall
                ? Obx(() => !controller.isPlaying.value
                    ? Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                            radius: 30.r,
                            backgroundColor: Colors.black.withOpacity(0.2),
                            child: IconButton(
                                onPressed: () {
                                  controller.playVideo();
                                },
                                icon: Icon(
                                  Icons.play_arrow,
                                  size: 25.h,
                                ))),
                      )
                    : SizedBox())
                : SizedBox(),
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    controller.pauseVideo();
                    Get.back();
                  },
                  icon: Icon(
                    Icons.clear,
                    size: 30.h,
                  ),
                )),
            controller.chatModel.mediaType == AppStrings.videoSmall
                ? Obx(() => !controller.isPlaying.value
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 100.h,
                          child: Slider(
                              max: controller.videoController.value.value
                                  .duration.inMicroseconds
                                  .toDouble(),
                              min: 0,
                              value: controller.videoTimer.value,
                              onChanged: (value) {
                                controller.videoController.value.seekTo(
                                    Duration(microseconds: value.toInt()));
                              }),
                        ),
                      )
                    : SizedBox())
                : SizedBox()
          ],
        ),
      )),
    );
  }
}
