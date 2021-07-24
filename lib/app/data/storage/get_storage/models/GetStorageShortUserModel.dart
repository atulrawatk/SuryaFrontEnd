import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:surya/app/data/encryption/aes.dart';
import 'package:surya/app/data/storage/get_storage/models/GetStorageUserModel.dart';
import 'package:surya/app/utils/strings.dart';

class SessionManager {

  SessionManager._();
  factory SessionManager(){
    return SessionManager._();
  }
  final _myStorage = GetStorage();



  Future<void> saveString(String key, String value) async {
    _myStorage.write(key, value);
    print("String saved--$value");
  }

  Future<String?> getString(String key) async {
    String? stringValue;
    stringValue = _myStorage.read(key);
    print("String returned--$stringValue");
    return stringValue;
  }

  Future<void> saveToken(String value) async {
    _myStorage.write(AppStrings.userTokenKey, value);
    print("saveToken saved");
  }

  Future<String?> getToken() async {
    String? stringValue = _myStorage.read(AppStrings.userTokenKey);
    print("saveToken returned-$stringValue");
    return stringValue;
  }

  Future<void> saveBoolean(String key, bool value) async {
    _myStorage.write(key, value);
    debugPrint("Bool saved");
  }

  Future<bool> getBoolean(String key) async {
    bool boolValue;
    boolValue = _myStorage.read(key) ?? false;
    print("Bool returned-$boolValue");
    return boolValue;
  }

  clearSession() {
    _myStorage.erase();
    print("Session Cleared");
  }

  Future<void> saveUser(UserModel value) async {
    _myStorage.write(AppStrings.userDataKey, value);
    print('USER SAVED');
  }

  Future<UserModel?> getUser() async {
    var value = _myStorage.read(AppStrings.userDataKey);
    print('USER GET $value');
    if (value == null) {
      return null;
    } else
      return UserModel.fromJson(value,Get.find<AESEncryption>());
  }
}