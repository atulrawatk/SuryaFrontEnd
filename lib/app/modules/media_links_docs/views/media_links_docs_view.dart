import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/modules/chat/controllers/chat_controller.dart';
import 'package:surya/app/modules/group_chat/controllers/group_chat_controller.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/styles/app_text_style.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/utils.dart';
import 'package:video_player/video_player.dart';

import '../controllers/media_links_docs_controller.dart';

class MediaLinksDocsView extends GetView<MediaLinksDocsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IosBackButton(),
        title: Text(
          controller.model.name!.value,
          style: AppTextStyle.mainPageHeading(),
        ),
      ),
      body: Obx(() => controller.mediaMessages.length > 0
          ? GridView.count(
              childAspectRatio: (1 / 1),
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              shrinkWrap: true,
              padding: EdgeInsets.all(10.h),
              crossAxisCount: 4,
              children: List.generate(controller.mediaMessages.length, (index) {
                return Material(
                  child: InkWell(
                    onTap: () {
                      controller.openMedia(index);
                    },
                    child: Container(
                        width: 120.h,
                        margin: EdgeInsets.only(left: 5.w, right: 5.w),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: controller.mediaMessages[index].mediaType ==
                                    "image"
                                ? DecorationImage(
                                    image: FileImage(File(controller
                                        .mediaMessages[index].media!)),
                                    fit: BoxFit.cover)
                                : null),
                        child: controller.mediaMessages[index].mediaType ==
                                "audio"
                            ? Center(
                                child: Icon(Icons.audiotrack,
                                    color: AppColors.whiteColor))
                            : controller.mediaMessages[index].mediaType ==
                                    "video"
                                ? Center(
                                    child: Icon(
                                    Icons.play_arrow,
                                    color: AppColors.whiteColor,
                                  ))
                                : controller.mediaMessages[index].mediaType ==
                                        "document"
                                    ? Center(
                                        child: Icon(Icons.perm_media,
                                            color: AppColors.whiteColor))
                                    : Container()),
                  ),
                );
              }),
            )
          : Center(
              child: Text(
              AppStrings.thereIsNoMedia,
              style: AppTextStyle.mainPageHeading(),
            ))),
    );
  }
}
