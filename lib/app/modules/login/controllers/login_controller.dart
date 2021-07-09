import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //

  final GlobalKey<FormState> loginKey = GlobalKey();

  final RxString _mobileNumber = RxString('');
  String get mobileNumber => this._mobileNumber.value;
  set mobileNumber(String? text) => this._mobileNumber.value = text!;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _mobileNumber.close();
  }
}
