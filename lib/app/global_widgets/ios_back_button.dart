import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/utils/styles/colors.dart';
import 'package:surya/app/utils/styles/theme_service.dart';
class IosBackButton extends StatelessWidget {
  const IosBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios,
      color: ThemeService.isDark.value?Colors.white:Colors.black,
      ),
      padding: EdgeInsets.zero,
      onPressed: (){
        Get.back();
      },
    );
  }
}
