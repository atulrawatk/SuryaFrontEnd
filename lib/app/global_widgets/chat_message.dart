import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:surya/app/modules/chat/controllers/chat_controller.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/utils.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        return SwipeTo(
            onRightSwipe: () {
              chatController.replyMessage.value = modelList[index];
              chatController.replyMsg.value=true;
            },
            rightSwipeWidget: Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: Icon(Icons.reply),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h, right: 5.w, left: 5.w),
              child: Align(
                alignment: modelList[index].isMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 200.w),
                  padding: EdgeInsets.only(
                      top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
                  child: Column(
                    children: [
                      modelList[index].repliedMessage!=null?Container(
                        width: Get.width,
                        margin: EdgeInsets.only(
                            top: 5.h, right: 10.w),
                        decoration: BoxDecoration(
                            color: AppColors.chatBg
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding:
                          EdgeInsets.all(10.h),
                          child: ListView(
                            shrinkWrap: true,
                            physics:
                            NeverScrollableScrollPhysics(),
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.only(
                                    bottom: 4.h),
                                child: Text(
                                  modelList[index]
                                      .repliedMessage!.name
                                      .isNotEmpty
                                      ? modelList[index]
                                      .repliedMessage!.name
                                      : AppStrings
                                      .you,
                                  style: AppTextStyle
                                      .repliedUserNameChat(),
                                ),
                              ),
                              Text(
                                modelList[index]
                                    .repliedMessage!
                                    .message,
                                maxLines: 2,
                                overflow: TextOverflow
                                    .ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ):SizedBox(),
                      Padding(
                        padding:  EdgeInsets.only(top:modelList[index]
                            .repliedMessage!=null?5.h:0),
                        child: Text(
                          modelList[index].message,
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft:
                        Radius.circular(modelList[index].isMe ? 15.r : 0),
                        topRight:
                        Radius.circular(modelList[index].isMe ? 0 : 15.r),
                        bottomLeft: Radius.circular(15.r),
                        bottomRight: Radius.circular(15.r),
                      ),
                      color: Get.theme.primaryColor),
                ),
              ),
            ));
      },
      itemCount: modelList.length,
      physics: BouncingScrollPhysics(),
      //reverse: true,
    );
  }
}
