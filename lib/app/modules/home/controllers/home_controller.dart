import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/data/socket/SocketService.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/strings.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin{

  late TabController tabController;


  //Tab Index Setter & Getter
  var tabIndex=0.obs;
  // int get tabIndex=>_tabIndex.value;
  // set setTabIndex(int value) {
  //   _tabIndex.value;
  // }

  RxString _chatType="".obs;
  String get chatType=>_chatType.value;
  set setChatType(String value){
    _chatType.value=value;
  }
  
  navigateToNewChatOrPhone(){
    setChatType=AppStrings.chat;
    Get.toNamed(Routes.NEW_CHAT_LIST);
  }

  @override
  void onInit() {
    super.onInit();

    onInitializer();
    SocketService().createSocketConnection("", notificationId: "");
  }

  onInitializer() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    tabController.addListener(_handleTabSelection);
  }
  _handleTabSelection() {
    if (tabController.indexIsChanging||tabController.hasListeners) {
      tabIndex.value = tabController.index;
      // update();
    }
  }

  @override
  void onReady() {
    super.onReady();

  }

  @override
  void onClose() {
    super.onClose();
  }
}
