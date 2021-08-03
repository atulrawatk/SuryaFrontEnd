import 'package:flutter/material.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ChatMessageField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool showTrackOnHover;
   ChatMessageField({Key? key,
  required this.controller,
    required this.hintText,
    required this.showTrackOnHover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      showTrackOnHover: showTrackOnHover,
      thickness: 2.h,
      radius: Radius.circular(10.r),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          TextField(
            controller: controller,
            maxLines: null,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: AppTextStyle.chatLabelText()
            ),
          ),
        ],
      ),
    );
  }
}
