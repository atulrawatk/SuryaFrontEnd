// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/utils/styles/custom_styles.dart';

class ThemeController extends GetxController {
  //

//   Rx<ThemeData> _isDarkTheme = Rx<ThemeData>(AppTheme.darkTheme);
//   ThemeData get isDarkTheme => this._isDarkTheme.value;
//   set isDarkTheme(ThemeData v) => this._isDarkTheme.value = v;
// }
  void themeChange(bool check) {
    if (check) {
      Get.changeTheme(AppTheme.darkTheme);
    } else {
      Get.changeTheme(AppTheme.lightTheme);
    }
  }
}
/*
 ElevatedButton(
              onPressed: () {
                // Get.changeTheme(
                //   Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
                // );

                Get.changeTheme(AppTheme.darkTheme);
                // Get.

                print("Theme:${Get.isDarkMode}");
              },
              child: Text("Dark theme!")),
          ElevatedButton(
              onPressed: () {
                // Get.changeTheme(
                //   Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
                // );

                Get.changeTheme(AppTheme.lightTheme);
                // Get.

                print("Theme:${Get.isDarkMode}");
              },
              child: Text("Light theme!")),
*/
