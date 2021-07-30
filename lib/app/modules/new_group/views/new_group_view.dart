import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/data/models/ContactUsers.dart';
import 'package:surya/app/global_widgets/contact_circle_avatar.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/global_widgets/group_contact_list_member.dart';
import 'package:surya/app/global_widgets/group_contact_list_tile.dart';
import 'package:surya/app/global_widgets/selected_contact_circle_avatar.dart';
import 'package:surya/app/utils/images.dart';
import 'package:surya/app/utils/lists.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';

import '../controllers/new_group_controller.dart';

class NewGroupView extends GetView<NewGroupController> {
  @override
  Widget build(BuildContext context) {
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
            Obx(() => controller.contacts.length > 0
                ? AspectRatio(
                    aspectRatio: 4,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(right: 15.h, left: 15.h),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10.h),
                          child: GestureDetector(
                            onTap: (){
                              controller.contacts.remove(controller.contacts.keys.elementAt(index));
                            },
                            child: GroupContactListMember(
                              name: controller.contacts.values.elementAt(index).name),
                          ),
                        );
                      },
                      itemCount: controller.contacts.length,
                    ),
                  )
                : Container()),
            // Divider(),
            // Obx(() => controller.totalList.length > 0?
                ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (_, i) {
                      return Obx(()=>GroupContactListTile(
                        onTap: () {
                          if (controller.contacts
                              .containsKey(controller.totalList[i].name)) {
                            controller.contacts
                                .remove(controller.totalList[i].name);
                          } else {
                            controller.contacts.putIfAbsent(
                                controller.totalList[i].name,
                                    () => controller.totalList[i]);
                          }
                         // controller.setGroupMemberList = 1;
                        },
                        isOnTap: true,
                        title: controller.totalList[i].name,
                        subTitle: Text(
                          controller.totalList[i].number.toString(),
                          textAlign: TextAlign.left,
                          style: AppTextStyle.multiChatMessage(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),

                        customWidget: Text(""),
                        circleAvatar: !controller.contacts.containsKey(controller.totalList[i].name)
                            ?ContactCircleAvatar(imageUrl: AppImages.dummyProfileImage,)
                            :SelectedContactCircleAvatar(imageUrl: AppImages.dummyProfileImage),
                      ));
                    },
                    // separatorBuilder: (_, i) => Divider(),
                    itemCount: controller.totalList.length,
                  )
                // : SizedBox())
          ],
        ),
    floatingActionButton: Obx(() => controller.contacts.length > 0?FloatingActionButton(
      onPressed: () {
      },
      child:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r)
        ),
            child: Icon(
        Icons.arrow_forward_ios,
        size: AppDimen.normalSize,
        color: Get.theme.accentColor,
      ),
          ),
      backgroundColor: AppColors.lightAppColor,
    ):SizedBox())
    );
  }
}
