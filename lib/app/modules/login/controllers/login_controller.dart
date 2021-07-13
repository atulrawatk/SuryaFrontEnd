import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //

  late GlobalKey<FormState> loginKey;

  final TextEditingController mobileController=new TextEditingController();
  final RxString _mobileNumber = RxString('');
  final RxBool _isLoading=RxBool(false);
  bool get isLoading=>this._isLoading.value;
  set setLoadingStatus(bool? status)=>this._isLoading.value=status!;
  String get mobileNumber => this._mobileNumber.value;
  set mobileNumber(String? text) => this._mobileNumber.value = text!;



  @override
  void onInit() {
    super.onInit();
    loginKey = GlobalKey<FormState>();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    mobileController.dispose();
    _mobileNumber.close();
    _isLoading.close();
  }
}
