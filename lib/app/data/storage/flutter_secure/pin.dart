import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:surya/app/data/storage/flutter_secure/flutter_secure_main.dart';
import 'package:surya/app/utils/strings.dart';

class PinStorage{

  PinStorage._();
  factory PinStorage()=>PinStorage._();



  setScreenPin(String pin)
  async {
    await FlutterSecureMain.secureStorage.write(key: AppStrings.screenPin, value: pin).then((value){
      debugPrint("Set Screen Pin Successfully");
    });
  }

  Future<String?> getScreenPin() async {

    String? value = await FlutterSecureMain.secureStorage.read(key: AppStrings.screenPin);
    return value;
  }
}