import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surya/app/utils/strings.dart';

class FirebaseService{
  static Future<String> getFirebaseTokenFromNative() async {
    debugPrint("start background services");
    String data = "";
    if (Platform.isAndroid) {
      var methodChannel = MethodChannel(AppStrings.methodChannel);
      data = await methodChannel.invokeMethod("firebaseToken");
    }
    return data;
  }
}