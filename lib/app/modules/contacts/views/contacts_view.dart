import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';

import 'package:surya/app/utils/lists.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/utils.dart';

import '../controllers/contacts_controller.dart';

class ContactsView extends GetView<ContactsController> {
  @override
  Widget build(BuildContext context) {
    // controller.onReady();
    return Scaffold(
        appBar: AppBar(
          title: Obx(
            () => controller.isSearch == false
                ? ListTile(
                    title: Text('Select Contact'),
                    subtitle: Text("100 contacts"),
                  )
                : TextFormField(
                    maxLines: 1,

                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
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
            () => controller.isSearch == false
                ? IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      controller.isSearch = false;
                    },
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                  ),
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
                        onSelected: (value) {},
                        itemBuilder: (BuildContext context) {
                          return AppLists.choicesForContacts
                              .map((String choices) {
                            return PopupMenuItem<String>(
                              value: choices,
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
        body: ListView(
          physics: ScrollPhysics(),
          controller: controller.scrollController,
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10.h,
            ),
            ListTile(
              title: Text(
                "New Group",
                textAlign: TextAlign.left,
                style: AppTextStyle.multiChatName(),
                textDirection: TextDirection.ltr,
              ),
              selected: true,
              // contentPadding: EdgeInsets.only(top: 10.h,),

              leading: CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.group_add,
                  color: Colors.white,
                ),
                backgroundColor: AppColors.lightAppColor,
              ),
              trailing: Text(""),
              onTap: () {},
              onLongPress: () {},
            ),
            // Divider(),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              itemBuilder: (_, i) {
                return UserListTile(
                  onTap: () {},
                  isOnTap: true,
                  title: "Sangam ",
                  subTitle: Text(
                    "9876543210",
                    textAlign: TextAlign.left,
                    style: AppTextStyle.multiChatMessage(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  imageUrl: AppImages.appLogo,
                  customWidget: Text(""),
                );
              },
              // separatorBuilder: (_, i) => Divider(),
              itemCount: 10,
            ),
          ],
        ));
  }
}
