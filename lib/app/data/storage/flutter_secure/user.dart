import 'package:flutter/material.dart';
import 'package:surya/app/data/storage/flutter_secure/flutter_secure_main.dart';
import 'package:surya/app/utils/strings.dart';

class SecureUserModel{
  setUserSessionSecure(String sessionToken) async{
    await FlutterSecureMain.secureStorage.write(key: AppStrings.screenPin, value: sessionToken).then((value){
      debugPrint("Set Screen Pin Successfully");
    });
  }
}