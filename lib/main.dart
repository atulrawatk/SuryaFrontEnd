import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/styles/custom_styles.dart';
import 'app/utils/utils.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'injection_class.dart';

void main() async {
  //load dot env file
  await dotenv.load(fileName: ".env");
  //
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Screentutils
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: Get.width,
        maxHeight: Get.height,
      ),
    );
    // Injection class
    InjectionClass.constcall();

    return GetMaterialApp(
      translations: Messages(), // your translations
      locale:
          Locale('en', 'US'), // translations will be displayed in that locale
      // fallbackLocale: Locale('en', 'UK'),
      title: "Surya",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
    );
  }
}
