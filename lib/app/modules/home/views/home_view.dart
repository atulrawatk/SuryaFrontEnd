import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        // centerTitle: true,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Get.changeTheme(
              Get.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
            );
          },
          child: Text(
            'HomeView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
