import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/utils.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: Get.width,
        maxHeight: Get.height,
      ),
    );
    return GetMaterialApp(
      translations: Messages(), // your translations
      locale:
          Locale('en', 'US'), // translations will be displayed in that locale
      // fallbackLocale: Locale('en', 'UK'),
      title: "Surya",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
