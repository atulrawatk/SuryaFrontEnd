import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/utils/utils.dart';

class ProfileImage extends StatelessWidget {
  final File profileImage;
  const ProfileImage({Key? key, required this.profileImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    Get.back();
                  }),
            ),
            Hero(
                tag: "profile_image",
                child: Align(
                  alignment: Alignment.center,
                  child: profileImage.path == ""
                      ? Image.asset(AppImages.dummyProfileImage)
                      : Image.file(
                          profileImage,
                          fit: BoxFit.fitWidth,
                        ),
                ))
          ],
        ),
      ),
    );
  }
}
