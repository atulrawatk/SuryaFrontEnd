import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class UserImageEditMenu extends StatelessWidget {
  final Callback callback;
  final String hintText;
  final Icon icon;
  const UserImageEditMenu({Key? key,required this.callback,required this.hintText,required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: callback,
              icon: icon),
          Padding(
            padding: EdgeInsets.all(5.h),
            child: Text(hintText),
          )
        ],
      ),
    );
  }
}
