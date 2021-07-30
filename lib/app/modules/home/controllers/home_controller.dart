import 'dart:ffi';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/data/api/api_helper.dart';
import 'package:surya/app/data/models/OTPVerify.dart';
import 'package:surya/app/data/socket/SocketService.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/data/storage/get_storage/get_storage_keys.dart';
import 'package:surya/app/data/storage/get_storage/otp_verify_get_storage_service.dart';
import 'package:surya/app/modules/otp/controllers/otp_controller.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/enum_navigation.dart';
import 'package:surya/app/utils/strings.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  ApiHelper _apiHelper = Get.find<ApiHelper>();

  //Tab Index Setter & Getter
  var tabIndex = 0.obs;

  //Chat Type Status
  RxString _chatType = "".obs;
  String get chatType => _chatType.value;
  set setChatType(String value) {
    _chatType.value = value;
  }

  //User Model
  Rx<OtpVerify> _otpVerify = OtpVerify().obs;
  OtpVerify? get otpVerifyModel => _otpVerify.value;
  set setOTPVerifyModel(OtpVerify model) {
    _otpVerify.value = model;
  }

  //Navigating Screen to chat or phone call
  navigateToNewChatOrPhone() {
    Get.toNamed(
      Routes.CONTACTS,
      arguments: tabIndex.value == 0
          ? ContactList.chatContact
          : ContactList.callContact,
    );
  }

  // Contacts
  RxList<Contact> _mobileContactList = RxList<Contact>.empty();
  List<Contact> get mobileContactsList => _mobileContactList;
  set mobileContactsList(Iterable<Contact> list) {
    _mobileContactList.addAll(list);
  }

  Future getContacts() async {
    mobileContactsList =
        await ContactsService.getContacts(withThumbnails: false);
    Logger().i(
        "Here is total number of contacts =====>>>>> ${mobileContactsList.length}");
  }

  // Search
  RxBool _isSearch = false.obs;
  bool get isSearch => this._isSearch.value;
  set isSearch(bool v) => this._isSearch.value = v;

  @override
  void onInit() {
    super.onInit();
    getUserDetails().then((value) {
      getUserThreads();
    }).catchError((error) {
      Logger().e(error.toString());
      return error;
    });
    onInitializer();
    getContacts();
  }

//Get User Details from DB
  Future getUserDetails() async {
    /* OTP controller used for storing user model for first time login
     because parsing was taking time when we trying to get
    the user model from local DB so here we getting the user model
    from setting value at otp screen in response and getting on home page,
    It is only for first time(app installed, logging) and
     for second time(app reopened or reboot) we are getting value from local db
     */
    Get.lazyPut(() => OtpController());
    OtpController controller = Get.find<OtpController>();
    if (controller.userModel.value.success != null) {
      setOTPVerifyModel = controller.userModel.value;
      Logger().w(
          "Token =====>>>> ${otpVerifyModel!.success!.data!.verificationToken}");
      Logger().i("=>>>Successfully User Model Imported from DB");
    } else {
      setOTPVerifyModel = OtpVerify.fromJson(
          AppGetStorage.getValue(GetStorageKeys.otpVerifyModelKey));
      Logger().w(
          "Token =====>>>> ${otpVerifyModel!.success!.data!.verificationToken}");
      Logger().i("=>>>Successfully User Model Imported from DB");
    }
  }

//Get User Threads From API
  getUserThreads() async {
    String? userId = otpVerifyModel!.success!.data!.id;
    debugPrint(userId);
    await _apiHelper
        .getUserThreads(
            userId: otpVerifyModel!.success!.data!.id,
            authToken: otpVerifyModel!.success!.data!.verificationToken)
        .then((value) {
      Logger().i("=====>>>>> Successful to get User threads");
    }).catchError((error) {
      Logger()
          .e("======>>>> Error in Getting User Threads ${error.toString()}");
    });
  }

  //Tab Controller for homepage chats or calls screen
  onInitializer() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    tabController.addListener(_handleTabSelection);
  }

  //Handling tab selection
  _handleTabSelection() {
    if (tabController.indexIsChanging || tabController.hasListeners) {
      tabIndex.value = tabController.index;
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
