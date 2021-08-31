import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:surya/app/modules/chat/controllers/chat_controller.dart';
import 'package:surya/app/modules/chat_media/controllers/chat_media_controller.dart';
import 'package:surya/app/modules/chat_media/views/chat_media_view.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/theme_service.dart';
import 'package:surya/app/utils/utils.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class ChatMessage extends StatelessWidget {
  final List<ChatMessageModel> modelList;
  final ScrollController scrollController;
  final ChatController chatController;
  ChatMessage(
      {Key? key,
      required this.modelList,
      required this.scrollController,
      required this.chatController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      // reverse: true,
      itemBuilder: (context, index) {
        return Obx(() => GestureDetector(
              onLongPress: () {
                if (chatController.selectedMessages.isEmpty) {
                  modelList[index].isSelected.value = true;
                  chatController.selectedMessages.add(modelList[index]);
                }
              },
              onTap: () {
                if (chatController.selectedMessages.isNotEmpty) {
                  if (chatController.selectedMessages
                      .contains(modelList[index])) {
                    modelList[index].isSelected.value = false;
                    chatController.selectedMessages.remove(modelList[index]);
                  } else {
                    modelList[index].isSelected.value = true;
                    chatController.selectedMessages.add(modelList[index]);
                  }
                }
              },
              child: SwipeTo(
                  onRightSwipe: () {
                    chatController.replyMessage.value = modelList[index];
                    chatController.replyMsg.value = true;
                  },
                  rightSwipeWidget: Padding(
                    padding: EdgeInsets.only(left: 25.w),
                    child: Icon(Icons.reply),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                    color: modelList[index].isSelected.value
                        ? Get.theme.primaryColor.withOpacity(0.5)
                        : Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 10.h, right: 5.w, left: 5.w, top: 10.h),
                      child: Align(
                        alignment: modelList[index].isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 200.w),
                          padding: EdgeInsets.all(10.h),
                          child: modelList[index].messageType ==
                                  AppStrings.textSmall
                              ? Column(
                                  children: [
                                    modelList[index].repliedMessage != null
                                        ? Container(
                                            width: Get.width,
                                            margin: EdgeInsets.only(
                                                top: 5.h, right: 10.w),
                                            decoration: BoxDecoration(
                                                color: AppColors.chatBg
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.h),
                                              child: ListView(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 4.h),
                                                    child: Text(
                                                      modelList[index]
                                                              .repliedMessage!
                                                              .name
                                                              .isNotEmpty
                                                          ? modelList[index]
                                                              .repliedMessage!
                                                              .name
                                                          : AppStrings.you,
                                                      style: AppTextStyle
                                                          .repliedUserNameChat(),
                                                    ),
                                                  ),
                                                  Text(
                                                    modelList[index]
                                                        .repliedMessage!
                                                        .message,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              modelList[index].repliedMessage !=
                                                      null
                                                  ? 5.h
                                                  : 0),
                                      child: Text(
                                        modelList[index].message,
                                        maxLines: null,
                                      ),
                                    ),
                                  ],
                                )
                              : modelList[index].mediaType ==
                                      AppStrings.audioSmall
                                  ? IconButton(
                                      color: Get.theme.accentColor,
                                      icon: !modelList[index].isTapped.value
                                          ? Icon(Icons.play_arrow)
                                          : Icon(Icons.pause),
                                      onPressed: () async {
                                        chatController.isPlaying.value =
                                            !chatController.isPlaying.value;
                                        if (chatController.isPlaying.value) {
                                          await chatController.stopAudio();
                                          modelList[index].isTapped.value =
                                              true;
                                          if (modelList[index].isTapped.value) {
                                            chatController.animController
                                                .forward();
                                            await chatController
                                                .playAudio(
                                                    modelList[index].media.path)
                                                .whenComplete(() {
                                              chatController.isPlaying.value =
                                                  false;
                                              modelList[index].isTapped.value =
                                                  false;
                                              chatController.animController
                                                  .reverse();
                                            });
                                          }
                                        } else {
                                          chatController.isPlaying.value =
                                              false;
                                          modelList[index].isTapped.value =
                                              false;
                                          await chatController.stopAudio();
                                        }
                                      },
                                    )
                                  : modelList[index].mediaType ==
                                          AppStrings.imageSmall
                                      ? Material(
                              color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              if (chatController
                                                  .selectedMessages.isEmpty) {
                                                Future.delayed(
                                                    Duration.zero,
                                                    () => Get.toNamed(
                                                        Routes.CHAT_MEDIA));
                                                chatController.mediaController
                                                        .chatModel =
                                                    modelList[index];
                                              } else {
                                                if (chatController
                                                    .selectedMessages
                                                    .contains(
                                                        modelList[index])) {
                                                  modelList[index]
                                                      .isSelected
                                                      .value = false;
                                                  chatController
                                                      .selectedMessages
                                                      .remove(modelList[index]);
                                                } else {
                                                  modelList[index]
                                                      .isSelected
                                                      .value = true;
                                                  chatController
                                                      .selectedMessages
                                                      .add(modelList[index]);
                                                }
                                              }
                                            },
                                            child: Hero(
                                              tag: modelList[index].time,
                                              child: Container(
                                                height: 150.h,
                                                width: 150.h,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.r),
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          modelList[index]
                                                              .media),
                                                      fit: BoxFit.cover),
                                                  //   borderRadius: BorderRadius.circular(10.r)
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : modelList[index].mediaType ==
                                              AppStrings.videoSmall
                                          ? Material(
                            color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  if (chatController
                                                      .selectedMessages
                                                      .isEmpty) {
                                                    chatController
                                                            .mediaController
                                                            .videoController
                                                            .value =
                                                        VideoPlayerController
                                                            .file(
                                                                modelList[index]
                                                                    .media)
                                                          ..initialize()
                                                              .whenComplete(() {
                                                            Future.delayed(
                                                                Duration.zero,
                                                                () => Get.toNamed(
                                                                    Routes
                                                                        .CHAT_MEDIA));
                                                            chatController
                                                                .mediaController
                                                                .videoListeners();
                                                          });
                                                    chatController
                                                            .mediaController
                                                            .chatModel =
                                                        modelList[index];
                                                  } else {
                                                    if (chatController
                                                        .selectedMessages
                                                        .contains(
                                                            modelList[index])) {
                                                      modelList[index]
                                                          .isSelected
                                                          .value = false;
                                                      chatController
                                                          .selectedMessages
                                                          .remove(
                                                              modelList[index]);
                                                    } else {
                                                      modelList[index]
                                                          .isSelected
                                                          .value = true;
                                                      chatController
                                                          .selectedMessages
                                                          .add(
                                                              modelList[index]);
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  height: 150.h,
                                                  width: 150.h,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r)),
                                                  child: Center(
                                                    child: CircleAvatar(
                                                      radius: 20.r,
                                                      backgroundColor: Colors.grey[800],
                                                      child: Icon(
                                                        Icons.play_arrow,
                                                        color:AppColors.whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : modelList[index].mediaType ==
                                                  AppStrings.documentSmall
                                              ? Material(
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 40.h,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .primaryDarkColor),
                                                      child: Center(
                                                          child: Text(
                                                              modelList[index]
                                                                  .media
                                                                  .path
                                                                  .split("/")
                                                                  .last)),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    modelList[index].isMe ? 15.r : 0),
                                topRight: Radius.circular(
                                    modelList[index].isMe ? 0 : 15.r),
                                bottomLeft: Radius.circular(15.r),
                                bottomRight: Radius.circular(15.r),
                              ),
                              color: Get.theme.primaryColor),
                        ),
                      ),
                    ),
                  )),
            ));
      },
      itemCount: modelList.length,
      physics: BouncingScrollPhysics(),
      //reverse: true,
    );
  }
}
