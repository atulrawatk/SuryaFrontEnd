import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:surya/app/global_widgets/global_widgets.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import '../controllers/login_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends GetView<LoginController> {
  //  LoginController _loginController = Get.put(
  //   LoginController(),
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Login',
      //   ),
      //   centerTitle: true,
      // ),
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Center(
          child: Form(
            key: controller.loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: TextFormField(
                    onChanged: (input) => controller.mobileNumber = input,
                  ),
                ),
                CustomButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
