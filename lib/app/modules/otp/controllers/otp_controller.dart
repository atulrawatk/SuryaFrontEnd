import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpController extends GetxController {
  //TODO: Implement OtpController

  final count = 0.obs;
  final scaffoldKey=GlobalKey<ScaffoldState>();
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  TextEditingController textEditingController=new TextEditingController();
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
  }
  void increment() => count.value++;
}
