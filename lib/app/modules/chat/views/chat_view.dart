import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/global_widgets/ChatMessageField.dart';
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
        child: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              child: Image.asset(
                AppStrings.chatBackground,
                color: AppColors.transparentAppColor,
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 50.h,
                width: Get.width,
                decoration: BoxDecoration(color: Get.theme.primaryColor),
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
                                return AppLists.chatMenu.map((String choices) {
                                  return PopupMenuItem<String>(
                                    value: choices,
                                    child: Text(choices),
                                    textStyle: AppTextStyle.multiChatMessage(),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.all(5.w),
                      child: Obx(()=>AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        height: controller.textFieldHeight.value,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Get.theme.backgroundColor,
                            borderRadius: BorderRadius.circular(50.r)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: Row(
                            children: [
                              Flexible(child: Icon(Icons.emoji_emotions)),
                              Expanded(
                                flex: 5,
                                child: ChatMessageField(
                                  controller: controller.textEditingController,
                                  hintText: AppStrings.enterAMessage,
                                  showTrackOnHover: true,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: CircleAvatar(
                        radius: 22.5.r,
                        backgroundColor: Get.theme.primaryColor,
                        child:Obx(()=> IconButton(
                          onPressed: () {},
                          icon: controller.sendStatus.value?Icon(Icons.near_me_sharp):Icon(Icons.mic),
                          color: Get.theme.accentColor,
                        )
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
