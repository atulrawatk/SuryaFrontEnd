import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/utils/utils.dart';

class ProfileImage extends StatelessWidget {
  final String profileImage;
  const ProfileImage({Key? key, required this.profileImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
                tag: "profile_image",
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: Get.height/1.2,
                    width: Get.width,
                    child: profileImage == ""
                        ? Image.asset(AppImages.dummyProfileImage)
                        : Image.file(
                            File(profileImage),
                            fit: BoxFit.fitHeight,
                          ),
                  ),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    Get.back();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
