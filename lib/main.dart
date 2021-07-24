import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:surya/app/utils/initializer.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/styles/custom_styles.dart';
import 'app/utils/utils.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'injection_class.dart';

void main() async {
  //load dot env file
  await dotenv.load(fileName: ".env");
  Initializer.init();
  //
  runZonedGuarded<Future<void>>(
    () async {
      runApp(MyApp());
    },
    (dynamic error, StackTrace stackTrace) {
      Get.defaultDialog(title: 'Error occurred', middleText: '$error');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScreenUtils
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: Get.width,
        maxHeight: Get.height,
      ),
    );
    // Injection class
    InjectionClass.constcall();
    // ThemeController _themeController = Get.find();
    return GetMaterialApp(
      translations: Messages(), // your translations
      locale:
          Locale('en', 'US'), // translations will be displayed in that locale
      // fallbackLocale: Locale('en', 'UK'),
      title: "Surya",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // theme: (_themeController.isDarkTheme),
      theme: (Get.isDarkMode) ? AppTheme.darkTheme : AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.system,
    );
  }
}
