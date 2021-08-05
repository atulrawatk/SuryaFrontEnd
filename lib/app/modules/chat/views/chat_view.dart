import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/global_widgets/chat_message.dart';
import 'package:surya/app/global_widgets/chat_message_field.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/utils/lists.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';

import '../controllers/chat_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset(
            AppStrings.chatBackground,
            color: AppColors.transparentAppColor,
            fit: BoxFit.fitWidth,
          ).image)),
          child: Stack(
            children: [
              //Chat Messages
              Obx(() => Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: controller.replyMsg.value ? 115.h : 55.h,
                          top: 55.h),
                      child: ChatMessage(
                        modelList: controller.oneToOneChatModel.value,
                        scrollController: controller.scrollController,
                        chatController: controller,
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() => ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 6,
                              child: Padding(
                                padding: EdgeInsets.all(5.w),
                                child: Container(
                                  constraints: BoxConstraints(maxHeight: 150.h),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: Get.theme.backgroundColor,
                                      borderRadius:
                                          BorderRadius.circular(30.r)),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.w, top: 2.h, bottom: 2.h),
                                      child: Obx(() => ListView(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: [
                                              // Replied Message Field
                                              controller.replyMsg.value
                                                  ? Stack(
                                                      alignment:
                                                          Alignment.topRight,
                                                      children: [
                                                        Container(
                                                          width: Get.width,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5.h,
                                                                  right: 10.w),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .chatBg
                                                                  .withOpacity(
                                                                      0.3),
                                                              borderRadius: BorderRadius.only(
                                                                  topRight:
                                                                      Radius.circular(
                                                                          20.r),
                                                                  topLeft:
                                                                      Radius.circular(
                                                                          20.r),
                                                                  bottomLeft:
                                                                      Radius.circular(
                                                                          20.r),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                          20.r))),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.h),
                                                            child: ListView(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              4.h),
                                                                  child: Text(
                                                                    controller
                                                                            .replyMessage
                                                                            .value
                                                                            .name
                                                                            .isNotEmpty
                                                                        ? controller
                                                                            .replyMessage
                                                                            .value
                                                                            .name
                                                                        : AppStrings
                                                                            .you,
                                                                    style: AppTextStyle
                                                                        .repliedUserNameChat(),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  controller
                                                                      .replyMessage
                                                                      .value
                                                                      .message,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                        //Remove replied Message
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                      .replyMsg
                                                                      .value =
                                                                  false;
                                                              //controller.replyMessage=null;
                                                            },
                                                            child: Container(
                                                              width:
                                                                  Get.width / 6,
                                                              height: 35.h,
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: 18
                                                                            .w,
                                                                        top: 9
                                                                            .h),
                                                                child: Icon(
                                                                  Icons.clear,
                                                                  color: AppColors
                                                                      .grey_500,
                                                                  size: 20.h,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox(),

                                              // Chat Text Field
                                              Row(
                                                children: [
                                                  Flexible(
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            if (!controller
                                                                .emojiOpen
                                                                .value) {
                                                              controller
                                                                  .emojiOpen
                                                                  .value = true;
                                                              controller
                                                                  .messageFocusField
                                                                  .unfocus();
                                                            } else {
                                                              controller
                                                                      .emojiOpen
                                                                      .value =
                                                                  false;
                                                              controller
                                                                  .messageFocusField
                                                                  .requestFocus();
                                                            }
                                                          },
                                                          child: Icon(
                                                            !controller.emojiOpen
                                                                            .value &&
                                                                        controller
                                                                            .messageFocusField
                                                                            .hasFocus ||
                                                                    !controller
                                                                        .emojiOpen
                                                                        .value
                                                                ? Icons
                                                                    .emoji_emotions
                                                                : Icons
                                                                    .keyboard,
                                                            size: 20.h,
                                                          ))),
                                                  Flexible(
                                                    flex: 5,
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight: 80.h),
                                                      child: ChatMessageField(
                                                        controller: controller
                                                            .textEditingController,
                                                        hintText: AppStrings
                                                            .enterAMessage,
                                                        showTrackOnHover: true,
                                                        focusNode: controller
                                                            .messageFocusField,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ))),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(right: 5.w),
                                child: CircleAvatar(
                                  radius: 25.r,
                                  backgroundColor: Get.theme.primaryColor,
                                  child: Obx(() => IconButton(
                                        onPressed: () {
                                          controller.sendMessage();
                                        },
                                        icon: controller.sendStatus.value
                                            ? Icon(Icons.near_me_sharp)
                                            : Icon(Icons.mic),
                                        color: Get.theme.accentColor,
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                        controller.emojiOpen.value
                            ? WillPopScope(
                                onWillPop: () async {
                                  controller.emojiOpen.value = false;
                                  return false;
                                },
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AspectRatio(
                                    aspectRatio: 1.5,
                                    child: EmojiPicker(
                                      onEmojiSelected: (category, emoji) {
                                        controller.textEditingController.text =
                                            controller.textEditingController
                                                    .text +
                                                emoji.emoji;
                                        controller.scrollController.position
                                            .forcePixels(controller
                                                    .scrollController
                                                    .position
                                                    .maxScrollExtent +
                                                55.h);
                                      },
                                      onBackspacePressed: () {
                                        // Backspace-Button tapped logic
                                        // Remove this line to also remove the button in the UI
                                      },
                                      config: Config(
                                          columns: 8,
                                          emojiSizeMax: 24.0,
                                          verticalSpacing: 5,
                                          horizontalSpacing: 10.h,
                                          initCategory: Category.SMILEYS,
                                          bgColor: Color(0xFFF2F2F2),
                                          indicatorColor:
                                              Get.theme.primaryColor,
                                          iconColor: Colors.grey,
                                          iconColorSelected:
                                              Get.theme.primaryColor,
                                          progressIndicatorColor:
                                              Get.theme.primaryColor,
                                          showRecentsTab: true,
                                          recentsLimit: 28,
                                          noRecentsText: "No Recents",
                                          noRecentsStyle: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black26),
                                          categoryIcons: const CategoryIcons(),
                                          buttonMode: ButtonMode.MATERIAL),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 50.h,
                  width: Get.width,
                  decoration: BoxDecoration(color: AppColors.primaryDarkColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: IosBackButton(),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10.w),
                                height: 50.h,
                                child: Text(
                                  "Tushar",
                                  style: AppTextStyle.chatLabelText(),
                                )),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: PopupMenuButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  size: AppDimen.normalSize,
                                  color: AppColors.whiteColor,
                                ),
                                onSelected: (value) {},
                                itemBuilder: (BuildContext context) {
                                  return AppLists.chatMenu
                                      .map((String choices) {
                                    return PopupMenuItem<String>(
                                      value: choices,
                                      child: Text(choices),
                                      textStyle:
                                          AppTextStyle.multiChatMessage(),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
