import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/global_widgets/contact_circle_avatar.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'global_widgets.dart';
class SelectedContactCircleAvatar extends StatelessWidget {
  final String imageUrl;
  const SelectedContactCircleAvatar({Key? key,
  required this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ContactCircleAvatar(imageUrl:imageUrl ),
        Container(
          height: 55.h,
          width: 55.h,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 20.r,
              width: 20.r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Get.height / 2),
                  border: Border.all(color: Get.isPlatformDarkMode?Colors.black:Colors.white,width: 2),
                  color: AppColors.green
              ),
              child: Icon(
                Icons.done,
                color: Get.isPlatformDarkMode?Colors.black:Colors.white,
                size: 15.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
