import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/images.dart';
import 'package:surya/app/utils/lists.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/theme_service.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Obx(
            () => controller.isSearch == false
                ? Text(
                    AppStrings.appName,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: AppDimen.normalSize,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : TextFormField(
                    maxLines: 1,

                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    // controller: _searchtextController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: AppColors.lightGreyColor,
                      ),
                    ),
                  ),
          ),
          leading: Obx(
            () => controller.isSearch == true
                ? IconButton(
                    onPressed: () {
                      controller.isSearch = false;
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: ThemeService.isDark.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                : SizedBox(),
          ),
          // centerTitle: true,
          actions: [
            Obx(
              () => controller.isSearch == false
                  ? IconButton(
                      icon: Icon(
                        Icons.search,
                        size: AppDimen.normalSize,
                        color: AppColors.whiteColor,
                      ),
                      iconSize: AppDimen.normalFontSize,
                      onPressed: () {
                        controller.isSearch = !controller.isSearch;
                      },
                    )
                  : SizedBox(),
            ),
            Obx(
              () => controller.isSearch == false
                  ? Container(
                      alignment: Alignment.center,
                      child: PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          size: AppDimen.normalSize,
                          color: AppColors.whiteColor,
                        ),
                        onSelected: (value) {
                          if (value == AppStrings.settings.trim()) {
                            Get.toNamed(Routes.USER_PROFILE);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return AppLists.choicesForContacts
                              .map((String choices) {
                            return PopupMenuItem<String>(
                              value: choices,
                              enabled: true,
                              child: Text(choices),
                            );
                          }).toList();
                        },
                      ),
                    )
                  : SizedBox(),
            )
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Container(
                  color: Get.theme.primaryColor,
                  child: TabBar(
                    controller: controller.tabController,
                    indicatorColor: AppColors.whiteColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (i) {
                      controller.tabIndex.value = i;
                    },
                    tabs: [
                      Tab(
                        icon: Icon(
                            controller.tabIndex.value == 0
                                ? Icons.message
                                : Icons.message_outlined,
                            color: AppColors.whiteColor),
                      ),
                      Tab(
                        icon: Icon(
                            controller.tabIndex.value == 0
                                ? Icons.call_outlined
                                : Icons.call,
                            color: AppColors.whiteColor),
                      ),
                    ],
                  ),
                )),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  Obx(() {
                    controller.sortingMessages();
                    return controller.userList.length > 0
                        ? ListView.builder(
                            itemCount: controller.userList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Material(
                                color: AppColors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    if (controller.userList
                                        .elementAt(index)
                                        .isGroup!) {
                                      Get.toNamed(Routes.GROUP_CHAT,
                                          arguments: controller.userList
                                              .elementAt(index));
                                    } else {
                                      Get.toNamed(Routes.CHAT,
                                          arguments: controller.userList
                                              .elementAt(index));
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10.w,
                                                top: 10.h,
                                                bottom: 10.h),
                                            height: Get.height / 14,
                                            width: Get.height / 14,
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              image: DecorationImage(
                                                  image: AssetImage(AppImages
                                                      .dummyProfileImage),
                                                  fit: BoxFit.fill),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Get.height / 2),
                                            ),
                                          )),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: 10.w,
                                              top: 20.h,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 5.w),
                                                        child: Text(
                                                            controller.userList
                                                                .elementAt(
                                                                    index)
                                                                .name!
                                                                .value,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppTextStyle
                                                                .multiChatName()),
                                                      ),
                                                    ),
                                                    Flexible(
                                                        child:controller.userList[index].isGroup!?Container(
                                                      height: 15.h,
                                                      width: 30.w,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          border: Border.all(
                                                              color: Get.theme
                                                                  .accentColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.r)),
                                                      child: Center(
                                                          child: Text(
                                                        AppStrings.group,
                                                        style: AppTextStyle
                                                            .headingText(
                                                                color: Get.theme
                                                                    .accentColor,
                                                                fontSize: 8.h,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                      )),
                                                    ):Container())
                                                  ],
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: Get.height / 100),
                                                    child: Obx(() => Text(
                                                          controller.userList
                                                                      .elementAt(
                                                                          index)
                                                                      .messageList!
                                                                      .last
                                                                      .message ==
                                                                  ""
                                                              ? controller
                                                                  .userList
                                                                  .elementAt(
                                                                      index)
                                                                  .messageList!
                                                                  .last
                                                                  .mediaType!
                                                                  .toUpperCase()
                                                              : controller
                                                                  .userList
                                                                  .elementAt(
                                                                      index)
                                                                  .messageList!
                                                                  .last
                                                                  .message!,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: controller
                                                                      .userList
                                                                      .elementAt(
                                                                          index)
                                                                      .messageList!
                                                                      .last
                                                                      .message ==
                                                                  ""
                                                              ? AppTextStyle
                                                                  .repliedUserNameChat()
                                                              : AppTextStyle
                                                                  .multiChatMessage(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        )))
                                              ],
                                            ),
                                          )),
                                      Align(
                                        alignment: AlignmentDirectional.topEnd,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: 15.h,
                                            // right: 10.w,
                                          ),
                                          child: Text(
                                            controller.messageTime(index),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                        : Align(
                            child: Text(
                              AppStrings.thereIsNoMessages,
                              style: AppTextStyle.mainPageHeading(),
                            ),
                          );
                  }),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        return UserListTile(
                          isOnTap: true,
                          onTap: () {
                            Get.toNamed(Routes.AUDIO_CALLING);
                          },
                          title: "Sangam ",
                          subTitle: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.call_made,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "subTitle",
                                textAlign: TextAlign.left,
                                style: AppTextStyle.multiChatMessage(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          imageUrl: AppImages.appLogo,
                          customWidget: Icon(
                            Icons.call,
                            color: Colors.red,
                          ),
                        );
                      },
                      separatorBuilder: (_, i) => Divider(),
                      itemCount: 10),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: Obx(() => FloatingActionButton(
              onPressed: () {
                controller.navigateToNewChatOrPhone();
              },
              child: controller.tabIndex.value == 0
                  ? Icon(
                      Icons.add_comment,
                      size: AppDimen.normalSize,
                      color: AppColors.whiteColor,
                    )
                  : Icon(
                      Icons.add_ic_call_rounded,
                      size: AppDimen.normalSize,
                      color: AppColors.whiteColor,
                    ),
              backgroundColor: Get.theme.primaryColor,
            )));
  }
}
