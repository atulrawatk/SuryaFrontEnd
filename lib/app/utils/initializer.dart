import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/data/api/api_helper.dart';
import 'package:surya/app/data/encryption/aes.dart';
import 'package:surya/app/data/storage/flutter_secure/flutter_secure_main.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/theme_service.dart';

import '../../dot_env_controller.dart';

class Initializer {
  static void init() async{
    try {
      WidgetsFlutterBinding.ensureInitialized();
      _initScreenPreference();
      _initApis();
      _initServices();
      _initFlutterSecureStorage();

      await _initStorage().whenComplete(() async{
        await _getTheme().whenComplete(() {

        });
      });
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _getTheme() async{
    Logger().i(AppGetStorage.storage.hasData(AppStrings.appTheme));
    if(AppGetStorage.storage.hasData(AppStrings.appTheme)){
      String themeValue=AppGetStorage.storage.read(AppStrings.appTheme);
     switch(themeValue){
       case AppStrings.smallSystemTheme:
         Get.changeThemeMode(Get.isPlatformDarkMode?ThemeMode.dark:ThemeMode.light);
         ThemeService.isDark.value=Get.isPlatformDarkMode?true:false;
         Logger().i("Theme is Dark=====>>> ${ThemeService.isDark.value}");

         break;
       case AppStrings.smallDarkTheme:
         Get.changeThemeMode(ThemeMode.dark);
         ThemeService.isDark.value=true;
         Logger().i("Theme is Dark=====>>> ${ThemeService.isDark.value}");
         break;
       case AppStrings.smallLightTheme:
         Get.changeThemeMode(ThemeMode.light);
         ThemeService.isDark.value=false;
         Logger().i("Theme is Dark=====>>> ${ThemeService.isDark.value}");
         break;
     }
    }else{
      ThemeService.isDark.value=Get.isPlatformDarkMode?true:false;
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
