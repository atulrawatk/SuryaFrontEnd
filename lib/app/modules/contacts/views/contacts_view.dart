import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/data/models/ContactUsers.dart';
import 'package:surya/app/data/models/chat_message_model.dart';
import 'package:surya/app/data/models/chat_user_model.dart';
import 'package:surya/app/data/models/my_chat_user_model.dart';
import 'package:surya/app/global_widgets/contact_circle_avatar.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/global_widgets/group_contact_list_member.dart';
import 'package:surya/app/global_widgets/group_contact_list_tile.dart';
import 'package:surya/app/global_widgets/selected_contact_circle_avatar.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/lists.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:surya/app/utils/styles/theme_service.dart';
import 'package:surya/app/utils/utils.dart';
import '../controllers/contacts_controller.dart';

class ContactsView extends GetView<ContactsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => controller.isAppBarChange == AppBarchange.normal
              ? ListTile(
                  title: Text('Select Contact'),
                  subtitle: Text("${controller.totalList.length} contacts"),
                )
              : controller.isAppBarChange == AppBarchange.search
                  ? TextFormField(
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      onChanged: (v) => controller.searchContacts = v,
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
                    )
                  : Text(
                      "${controller.contacts.length} contacts",
                      style: TextStyle(
                        color: ThemeService.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
        ),
        leading: Obx(
          () => controller.isAppBarChange == AppBarchange.normal
              ? IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color:
                        ThemeService.isDark.value ? Colors.white : Colors.black,
                  ),
                )
              : controller.isAppBarChange == AppBarchange.search
                  ? IconButton(
                      onPressed: () {
                        controller.searchContacts = "";
                        // controller.isSearch = false;
                        controller.isAppBarChange = AppBarchange.normal;
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: ThemeService.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        // controller.searchContacts = "";
                        // select contacts remove
                        // controller.isSearch = false;
                        controller.isAppBarChange = AppBarchange.normal;
                        controller.contacts.clear();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: ThemeService.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
        ),
        // centerTitle: true,
        actions: [
          Obx(
            () => controller.isAppBarChange == AppBarchange.normal
                ? IconButton(
                    icon: Icon(
                      Icons.search,
                      size: AppDimen.normalSize,
                      color: AppColors.whiteColor,
                    ),
                    iconSize: AppDimen.normalFontSize,
                    onPressed: () {
                      // controller.isSearch = !controller.isSearch;
                      controller.isAppBarChange = AppBarchange.search;
                    },
                  )
                : SizedBox(),
          ),
          Obx(
            () => controller.isAppBarChange == AppBarchange.normal
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
          Obx(
            () => controller.contacts.length > 0
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
                            onTap: () {
                              controller.contacts.remove(
                                  controller.contacts.keys.elementAt(index));
                              if (controller.contacts.length < 1) {
                                controller.isAppBarChange = AppBarchange.normal;
                              }
                            },
                            child: GroupContactListMember(
                                name: controller.contacts.values
                                    .elementAt(index)
                                    .name),
                          ),
                        );
                      },
                      itemCount: controller.contacts.length,
                    ),
                  )
                : Container(),
          ),
          Obx(
            () => controller.searchContacts.isEmpty ||
                    controller.searchContacts.isBlank == true
                ? ListTile(
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
                    onTap: () {
                      Get.toNamed(Routes.NEW_GROUP);
                    },
                    onLongPress: () {},
                  )
                : SizedBox(),
          ),
          // Divider(),
          // PageView.builder(itemBuilder: itemBuilder),
          Obx(
            () => controller.searchContacts.isEmpty ||
                    controller.searchContacts.isBlank == true
                ? ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    itemBuilder: (_, i) {
                      ContactUsers contact = controller.totalList.elementAt(i);
                      return Obx(
                        () => GroupContactListTile(
                          onTap: () {
                            if (controller.contacts.length > 0) {
                              if (controller.contacts
                                  .containsKey(contact.name)) {
                                controller.contacts.remove(contact.name);
                                if (controller.contacts.length < 1) {
                                  controller.isAppBarChange =
                                      AppBarchange.normal;
                                }
                              } else {
                                controller.contacts
                                    .putIfAbsent(contact.name, () => contact);
                              }
                            } else {
                              controller.toChat(contact.name,contact);
                            }
                          },
                          onLongPress: () {
                            if (controller.contacts.containsKey(contact.name)) {
                              controller.contacts.remove(contact.name);
                            } else {
                              controller.contacts
                                  .putIfAbsent(contact.name, () => contact);
                            }
                            controller.isAppBarChange =
                                AppBarchange.selectcontacts;
                          },
                          isOnTap: true,
                          title: contact.name,
                          subTitle: Text(
                            contact.number.toString(),
                            textAlign: TextAlign.left,
                            style: AppTextStyle.multiChatMessage(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          customWidget: Text(""),
                          circleAvatar:
                              !controller.contacts.containsKey(contact.name)
                                  ? ContactCircleAvatar(
                                      imageUrl: AppImages.dummyProfileImage,
                                    )
                                  : SelectedContactCircleAvatar(
                                      imageUrl: AppImages.dummyProfileImage),
                        ),
                      );
                    },
                    // separatorBuilder: (_, i) => Divider(),
                    itemCount: controller.totalList.length,
                  )
                : ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (_, i) {
                      ContactUsers contact = controller.totalList
                          .where(
                            (element) =>
                                element.name
                                    .toLowerCase()
                                    .contains(controller.searchContacts) ||
                                element.number.toString().contains(
                                    controller.searchContacts.toString()),
                          )
                          .elementAt(i);

                      Logger().i(
                          "Here is total number of contacts =====>>>>> ${contact.name} ${contact.number}");

                      return Obx(
                        () => contact.toString().isNotEmpty ||
                                contact.name.isNotEmpty ||
                                contact.number.toString().isNotEmpty ||
                                contact.number.isBlank == false ||
                                contact.name.isBlank == false
                            ? GroupContactListTile(
                                onTap: () {
                                  if (controller.contacts.length > 0) {
                                    if (controller.contacts
                                        .containsKey(contact.name)) {
                                      controller.contacts.remove(contact.name);
                                      if (controller.contacts.length < 1) {
                                        controller.isAppBarChange =
                                            AppBarchange.normal;
                                      }
                                    } else {
                                      controller.contacts.putIfAbsent(
                                          contact.name, () => contact);
                                    }
                                  } else {
                                    controller.toChat(contact.name,contact);
                                  }
                                },
                                onLongPress: () {
                                  if (controller.contacts
                                      .containsKey(contact.name)) {
                                    controller.contacts.remove(contact.name);
                                  } else {
                                    controller.contacts.putIfAbsent(
                                        contact.name, () => contact);
                                  }
                                  controller.isAppBarChange =
                                      AppBarchange.normal;
                                },
                                isOnTap: true,
                                title: contact.name,
                                subTitle: Text(
                                  contact.number.toString(),
                                  textAlign: TextAlign.left,
                                  style: AppTextStyle.multiChatMessage(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                customWidget: Text(""),
                                circleAvatar: !controller.contacts
                                        .containsKey(contact.name)
                                    ? ContactCircleAvatar(
                                        imageUrl: AppImages.dummyProfileImage,
                                      )
                                    : SelectedContactCircleAvatar(
                                        imageUrl: AppImages.dummyProfileImage),
                              )
                            : Text(
                                "No results found for '${controller.searchContacts}'",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                    itemCount: controller.totalList
                        .where(
                          (element) =>
                              element.name
                                  .toLowerCase()
                                  .contains(controller.searchContacts) ||
                              element.number.toString().contains(
                                  controller.searchContacts.toString()),
                        )
                        .length,
                  ),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () => controller.contacts.length > 1
            ? FloatingActionButton(
                onPressed: () {
                  Get.offAndToNamed(Routes.NEW_GROUP_NAME_CHAT,
                      arguments: controller.contacts);
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: AppDimen.normalSize,
                    color: Get.theme.accentColor,
                  ),
                ),
                backgroundColor: AppColors.lightAppColor,
              )
            : SizedBox(),
      ),
    );
  }
}
