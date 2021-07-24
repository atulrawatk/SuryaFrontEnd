import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:surya/app/data/api/api_helper.dart';
import 'package:surya/app/data/encryption/aes.dart';
import 'package:surya/app/data/storage/flutter_secure/flutter_secure_main.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';

import '../../dot_env_controller.dart';

class Initializer {
  static void init() {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _initStorage();
      _initScreenPreference();
      _initApis();
      _initServices();
      _initFlutterSecureStorage();
    } catch (err) {
      rethrow;
    }
  }

  static void _initServices(){
    Get.put(DotEnvController());
    Get.put(ApiHelper());
    Get.put(AESEncryption());
  }
  static void _initFirebaseService(){
    Firebase.initializeApp();
    FirebaseMessaging messaging=FirebaseMessaging.instance;
  }

  static void _initFlutterSecureStorage(){
    FlutterSecureMain.initFlutterSecureStorage();
  }
  static void _initApis() {

  }

  static Future<void> _initStorage() async {
    await GetStorage.init();
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
