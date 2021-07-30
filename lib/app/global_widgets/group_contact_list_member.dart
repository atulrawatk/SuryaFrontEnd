import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/global_widgets/contact_circle_avatar.dart';
import 'package:surya/app/utils/images.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'global_widgets.dart';

class GroupContactListMember extends StatelessWidget {
  final String name;
  const GroupContactListMember({Key? key,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ContactCircleAvatar(imageUrl: AppImages.dummyProfileImage),
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
                  border: Border.all(color: Get.theme.primaryColor,width: 2),
                  color: AppColors.whiteColor
                  ),
                  child: Icon(
                    Icons.close,
                    color: Get.theme.primaryColor,
                    size: 15.r,
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top:10.h),
          child: Text(name,style: AppTextStyle.normalText(),),
        )
      ],
    );
  }
}
