import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/modules/home/controllers/home_controller.dart';
import 'package:surya/app/utils/utils.dart';

class ContactsController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  ScrollController scrollController = ScrollController();

  RxBool _isSearch = false.obs;
  bool get isSearch => this._isSearch.value;
  set isSearch(bool v) => this._isSearch.value = v;

  late ContactList contactList;

  @override
  void onInit() {
    super.onInit();
    debugPrint(homeController.chatType);
    contactList = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}