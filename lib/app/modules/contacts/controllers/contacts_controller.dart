import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/modules/home/controllers/home_controller.dart';
import 'package:surya/app/utils/utils.dart';

class ContactsController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  ScrollController scrollController = ScrollController();

  RxBool _isSearch = false.obs;
  bool get isSearch => this._isSearch.value;
  set isSearch(bool v) => this._isSearch.value = v;

  late ContactList contactList;

  //Getter & Setter for Contact List
  RxList<Contact> _mobileContactList=RxList<Contact>.empty();
  List<Contact> get mobileContactsList=>_mobileContactList;
  set setMobileContactList(Iterable<Contact> list){
    _mobileContactList.addAll(list);
  }

  //Get Contacts
  Future getContacts() async{
    setMobileContactList = await ContactsService.getContacts(withThumbnails: false);
    Logger().i("Here is total number of contacts =====>>>>> ${mobileContactsList.length}");
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint(homeController.chatType);
    contactList = Get.arguments;
    getContacts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}