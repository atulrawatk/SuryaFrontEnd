import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:surya/app/modules/splash/controllers/splash_controller.dart';
import 'package:surya/app/utils/images.dart';
import 'package:surya/app/utils/lists.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/padding.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                AppStrings.appName,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: AppDimen.normalSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: AppDimen.normalSize,
                      color: AppColors.whiteColor,
                    ),
                    iconSize: AppDimen.normalFontSize,
                    onPressed: () {},
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        size: AppDimen.normalSize,
                        color: AppColors.whiteColor,
                      ),
                      onSelected: (value) {},
                      itemBuilder: (BuildContext context) {
                        return AppLists.choices.map((String choices) {
                          return PopupMenuItem<String>(
                            value: choices,
                            child: Text(choices),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          // centerTitle: true,
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
                  ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      itemBuilder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 10.w,
                                    top: 10.h,
                                  ),
                                  height: Get.height / 14,
                                  width: Get.height / 14,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    image: DecorationImage(
                                        image: AssetImage(AppImages.appLogo),
                                        fit: BoxFit.fill),
                                    borderRadius:
                                        BorderRadius.circular(Get.height / 2),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Sangam",
                                          textAlign: TextAlign.left,
                                          style: AppTextStyle.multiChatName()),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Get.height / 100),
                                        child: Text(
                                          "Hii, This side Sangam ewfjw efr f ew f ewf ewf",
                                          textAlign: TextAlign.left,
                                          style:
                                              AppTextStyle.multiChatMessage(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 25.h,
                                  right: 10.w,
                                ),
                                child: Text(
                                  "Today",
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                  Text("")
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
              backgroundColor: AppColors.lightAppColor,
            )));
  }
}
