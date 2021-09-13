import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/global_widgets/chat_message.dart';
import 'package:surya/app/global_widgets/chat_message_field.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/global_widgets/user_image_edit_menu.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/app_dialog_box.dart';
import 'package:surya/app/utils/lists.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/theme_service.dart';
import 'package:surya/app/utils/utils.dart';

import '../controllers/group_chat_controller.dart';

class GroupChatView extends GetView<GroupChatController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset(
                      AppStrings.chatBackground,
                      color: AppColors.transparentAppColor,
                    ).image,
                    fit: BoxFit.cover)),
            child: Stack(
              children: [
                //Chat Messages
                Obx(() => Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: controller.replyMsg.value ? 115.h : 55.h,
                            top: 55.h),
                        child: Obx(() => ChatMessage(
                              modelList:
                                  controller.groupModel.messageList!.value,
                              scrollController: controller.scrollController,
                              chatController: controller,
                            )),
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
                              Expanded(
                                // flex: 6,
                                child: Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: Container(
                                    constraints:
                                        BoxConstraints(maxHeight: 150.h),
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        color: ThemeService.isDark.value
                                            ? Get.theme.backgroundColor
                                            : AppColors.grey_350,
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
                                                                    right:
                                                                        10.w),
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .chatBg
                                                                    .withOpacity(
                                                                        0.3),
                                                                borderRadius: BorderRadius.only(
                                                                    topRight:
                                                                        Radius.circular(20
                                                                            .r),
                                                                    topLeft: Radius.circular(
                                                                        20.r),
                                                                    bottomLeft:
                                                                        Radius.circular(20
                                                                            .r),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            20.r))),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.h),
                                                              child: ListView(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom:
                                                                            4.h),
                                                                    child: Text(
                                                                      controller
                                                                              .replyMessage
                                                                              .value
                                                                              .name!
                                                                              .isNotEmpty
                                                                          ? controller
                                                                              .replyMessage
                                                                              .value
                                                                              .name!
                                                                          : AppStrings
                                                                              .you,
                                                                      style: AppTextStyle
                                                                          .repliedUserNameChat(),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    controller
                                                                        .returnReplyMessage()!,
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
                                                                    Get.width /
                                                                        6,
                                                                height: 35.h,
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      right:
                                                                          18.w,
                                                                      top: 9.h),
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
                                                                maxHeight:
                                                                    80.h),
                                                        child: ChatMessageField(
                                                          controller: controller
                                                              .textEditingController,
                                                          hintText: AppStrings
                                                              .enterAMessage,
                                                          showTrackOnHover:
                                                              true,
                                                          focusNode: controller
                                                              .messageFocusField,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.attach_file,
                                                          color: Get.theme
                                                              .accentColor,
                                                          size: 22.w,
                                                        ),
                                                        onPressed: () {
                                                          Get.bottomSheet(
                                                              Container(
                                                                height: 100.h,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    UserImageEditMenu(
                                                                        callback:
                                                                            () {
                                                                          controller.attachFile(
                                                                              file: MediaType.document);
                                                                        },
                                                                        hintText: AppStrings
                                                                            .document
                                                                            .trim(),
                                                                        icon: Icon(
                                                                            Icons.file_copy)),
                                                                    UserImageEditMenu(
                                                                        callback:
                                                                            () {
                                                                          controller.attachFile(
                                                                              file: MediaType.video);
                                                                        },
                                                                        hintText: AppStrings
                                                                            .video
                                                                            .trim(),
                                                                        icon: Icon(
                                                                            Icons.video_collection)),
                                                                    UserImageEditMenu(
                                                                        callback:
                                                                            () {
                                                                          controller.attachFile(
                                                                              file: MediaType.audio);
                                                                        },
                                                                        hintText: AppStrings
                                                                            .audio
                                                                            .trim(),
                                                                        icon: Icon(
                                                                            Icons.audiotrack)),
                                                                    UserImageEditMenu(
                                                                        callback:
                                                                            () {
                                                                          controller.attachFile(
                                                                              file: MediaType.image);
                                                                        },
                                                                        hintText: AppStrings
                                                                            .image
                                                                            .trim(),
                                                                        icon: Icon(
                                                                            Icons.image))
                                                                  ],
                                                                ),
                                                              ),
                                                              backgroundColor: ThemeService
                                                                      .isDark
                                                                      .value
                                                                  ? AppColors
                                                                      .snackBarColor
                                                                  : AppColors
                                                                      .grey_350);
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ))),
                                  ),
                                ),
                              ),
                              Obx(() => AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: controller.isRecording.value
                                        ? 150.w
                                        : 60.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        controller.isRecording.value
                                            ? Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.w),
                                                  child: Icon(
                                                    Icons.fiber_manual_record,
                                                    color: AppColors.red,
                                                    size: 15.h,
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                        controller.isRecording.value
                                            ? Expanded(
                                                flex: 2,
                                                child: AnimatedDefaultTextStyle(
                                                  duration: Duration(
                                                      milliseconds: 400),
                                                  style: TextStyle(
                                                      fontSize: controller
                                                              .isRecording.value
                                                          ? 15
                                                          : 0),
                                                  child: Text(
                                                    controller
                                                        .recordingMessageTimer(),
                                                    textAlign: TextAlign.start,
                                                    style: AppTextStyle
                                                        .multiChatName(),
                                                  ),
                                                ))
                                            : SizedBox(),
                                        Flexible(
                                          child: GestureDetector(
                                            onLongPress: () async {
                                              await controller.startRecording();
                                            },
                                            onLongPressEnd: (end) async {
                                              await controller.stopRecording();
                                            },
                                            child: CircleAvatar(
                                              radius: 25.r,
                                              backgroundColor:
                                                  controller.isRecording.value
                                                      ? AppColors.green
                                                      : Get.theme.primaryColor,
                                              child: controller.sendStatus.value
                                                  ? IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .sendMessage();
                                                      },
                                                      icon: Icon(
                                                          Icons.near_me_sharp),
                                                      color:
                                                          Get.theme.accentColor,
                                                    )
                                                  : Icon(
                                                      Icons.mic,
                                                      color:
                                                          Get.theme.accentColor,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: controller.isRecording.value
                                            ? Colors.green
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(50.r)),
                                  ))
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
                                          controller.textEditingController
                                              .text = controller
                                                  .textEditingController.text +
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
                                            categoryIcons:
                                                const CategoryIcons(),
                                            buttonMode: ButtonMode.MATERIAL),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      )),
                ),
                Obx(
                  () => controller.selectedMessages.length > 0 &&
                          controller.issearch == false
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 85.h,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: AppColors.primaryDarkColor),
                            child: SafeArea(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: IconButton(
                                        onPressed: () {
                                          controller.selectedMessages
                                              .forEach((element) {
                                            element.isSelected!.value = false;
                                          });
                                          controller.selectedMessages.clear();
                                          controller.selectMsg.value = false;
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          size: 20.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            controller.removeMessages();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 20.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : controller.issearch == false &&
                              controller.selectedMessages.length < 1
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 85.h,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryDarkColor),
                                child: SafeArea(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: IconButton(
                                              onPressed: () {
                                                Get.offNamedUntil(
                                                    Routes.HOME,
                                                    ModalRoute.withName(
                                                        Routes.HOME));
                                              },
                                              icon: Icon(
                                                Icons.arrow_back_ios,
                                                color: ThemeService.isDark.value
                                                    ? Colors.white
                                                    : Colors.black,
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              controller.toOtherUserProfile();
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.w),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: CircleAvatar(
                                                      child: Hero(
                                                          tag: "chat_head",
                                                          child: Image.asset(
                                                              AppImages
                                                                  .dummyProfileImage)),
                                                    ),
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          left: 10.w),
                                                      height: 50.h,
                                                      child: Text(
                                                        controller.groupModel
                                                            .name!.value,
                                                        style: AppTextStyle
                                                            .chatLabelText(),
                                                      )),
                                                ],
                                              ),
                                            ),
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
                                                onSelected: (value) {
                                                  switch (value) {
                                                    case "Block":
                                                      AppDialogBox.showDialog(
                                                        AppStrings
                                                            .areYouSureToBlock,
                                                        title: "",
                                                        onTapYes: () {
                                                          Get.back();
                                                        },
                                                        onTapNo: () {},
                                                      );
                                                      break;
                                                    case "View Contact":
                                                      controller
                                                          .toOtherUserProfile();
                                                      break;
                                                    case "Media,links and docs":
                                                      Get.toNamed(
                                                          Routes
                                                              .MEDIA_LINKS_DOCS,
                                                          arguments: controller
                                                              .groupModel);
                                                      break;
                                                    case "Search":
                                                      controller.issearch =
                                                          true;
                                                      break;
                                                  }
                                                },
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return AppLists.chatMenu
                                                      .map((String choices) {
                                                    return PopupMenuItem<
                                                        String>(
                                                      value: choices,
                                                      child: Text(choices),
                                                      textStyle: AppTextStyle
                                                          .multiChatMessage(),
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
                            )
                          : Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 85.h,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryDarkColor),
                                child: SafeArea(
                                  child: Row(
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: IconButton(
                                            onPressed: () {
                                              controller.issearch = false;
                                            },
                                            icon: Icon(
                                              Icons.clear,
                                              size: 20.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                color: Colors.white,
                                              ),
                                              textInputAction:
                                                  TextInputAction.search,
                                              keyboardType: TextInputType.text,
                                              autofocus: true,
                                              onChanged: (v) =>
                                                  controller.searchText = v,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                hintText: 'Search...',
                                                hintStyle: TextStyle(
                                                  color:
                                                      AppColors.lightGreyColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          controller.stopAudio();
          return true;
        });
  }
}
