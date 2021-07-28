import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:surya/app/data/api/api_helper.dart';
import 'package:surya/app/modules/home/controllers/home_controller.dart';

class NewChatListController extends GetxController {
  HomeController homeController=Get.find<HomeController>();
  ApiHelper _apiHelper=Get.find<ApiHelper>();

  //Getter & Setter for Contact List
  RxList<Contact> _contactList=RxList<Contact>.empty();
  List<Contact> get contactList=>_contactList;
  set setContactList(Iterable<Contact> list){
    _contactList.addAll(list);
  }


  @override
  void onInit() {
    super.onInit();

    getContacts().then((value) {
      Logger().i("Here is total number of contacts =====>>>>> ${contactList.length}");
    });
    debugPrint(homeController.chatType);
  }

  Future getContacts() async{
    await Permission.contacts.status.then((value) async{
      if(PermissionStatus.granted!=value){
        Permission.contacts.request().then((value) async{
          setContactList = await ContactsService.getContacts(withThumbnails: false);
        });
      }
      else{
        setContactList = await ContactsService.getContacts(withThumbnails: false);
      }
    });

  }

  checkContacts() {
    _apiHelper;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
