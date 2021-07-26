import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/modules/home/controllers/home_controller.dart';

class NewChatListController extends GetxController {
  HomeController homeController=Get.find<HomeController>();
  @override
  void onInit() {
    super.onInit();
    debugPrint(homeController.chatType);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
