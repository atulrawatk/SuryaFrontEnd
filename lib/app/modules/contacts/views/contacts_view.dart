import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/routes/app_pages.dart';

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
                    subtitle: Text(
                        "${controller.mobileContactsList.length} contacts"),
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
                    onChanged: (v) => controller.searchContacts = v,
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
                      controller.searchContacts = "";
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
            Obx(
              () => controller.searchContacts.isEmpty ||
                      controller.searchContacts.isBlank == true
                  ? ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      itemBuilder: (_, i) {
                        //controller.mobileContactsList
                        Contact contact =
                            controller.mobileContactsList.elementAt(i);
                        return UserListTile(
                          onTap: () {},
                          isOnTap: true,
                          title: contact.displayName!=null?contact.displayName!:"",
                          subTitle: Text(
                            contact.phones != null && contact.phones!.isNotEmpty
                                ? contact.phones!.first.value!
                                : "",
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
                      itemCount: controller.mobileContactsList.length,
                    )
                  : ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      itemBuilder: (_, i) {
                        //controller.mobileContactsList
                        Contact contact = controller.mobileContactsList
                            .where(
                              (element) =>
                                  element.displayName!
                                      .toLowerCase()
                                      .contains(controller.searchContacts) ||
                                  element.phones!.first.value!.contains(
                                      controller.searchContacts.toString()),
                            )
                            .elementAt(i);
                        // print(
                        //     "Contacts clicks : ${contact.displayName ?? contact.phones!.first.value}");
                        Logger().i(
                            "Here is total number of contacts =====>>>>> ${contact.displayName ?? contact.phones!.first.value}");

                        return contact.toString().isNotEmpty ||
                                contact.displayName!.isNotEmpty ||
                                contact.phones!.first.value!.isNotEmpty ||
                                contact.phones != null ||
                                contact.displayName.isBlank == false ||
                                contact.isBlank == false
                            ? UserListTile(
                                onTap: () {},
                                isOnTap: true,
                                title: contact.displayName!,
                                subTitle: Text(
                                  contact.phones != null
                                      ? contact.phones!.first.value.toString()
                                      : "",
                                  textAlign: TextAlign.left,
                                  style: AppTextStyle.multiChatMessage(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                imageUrl: AppImages.appLogo,
                                customWidget: Text(""),
                              )
                            : Text(
                                "No results found for '${controller.searchContacts}'",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              );
                      },
                      // separatorBuilder: (_, i) => Divider(),
                      itemCount: controller.mobileContactsList
                          .where(
                            (element) =>
                                element.displayName!.toLowerCase().contains(
                                    controller.searchContacts.toString()) ||
                                element.phones!.first.value!.contains(
                                    controller.searchContacts.toString()),
                          )
                          .length,
                    ),
            ),
          ],
        ));
  }
}
