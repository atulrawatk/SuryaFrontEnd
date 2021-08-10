import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surya/app/utils/lists.dart';
import 'package:surya/app/utils/styles/custom_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMessageField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool showTrackOnHover;
  final FocusNode focusNode;
  ChatMessageField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.showTrackOnHover,
    required this.focusNode,
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
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.only(top: 15.h, left: 10.h),
              fillColor: Colors.transparent,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: AppTextStyle.chatLabelText(),
              suffixIcon: InkWell(
                  onTap: (){
                    focusNode.unfocus();
                    Get.bottomSheet(
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Text("weugfuiwehbf")
                          ],
                        ),
                      backgroundColor: Colors.transparent
                    );
                    focusNode.unfocus();
                  },
                  child: Container(
                    width: 60.w,
                    //color: Colors.red,
                    child: Icon(Icons.attach_file,
                    color: Get.theme.accentColor,
                    size: 30.w,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
