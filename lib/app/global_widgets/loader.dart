import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingOverlay {

  void hide() {
    Get.back();
  }

  void show() {
    Get.dialog(
        _FullScreenLoader()
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create();

  factory LoadingOverlay.of() {
    return LoadingOverlay._create();
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
        child: Center(child: CircularProgressIndicator(color: Get.theme.primaryColor,)));
  }
}