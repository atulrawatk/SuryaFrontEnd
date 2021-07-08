import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinCodeFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final StreamController<ErrorAnimationType> errorController;
  final Function(String?) onSaved;
  const PinCodeFieldWidget({
    Key? key,
    required this.controller,
    required this.errorController,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: TextStyle(
        color: Colors.green.shade600,
        fontWeight: FontWeight.bold,
      ),
      length: 4,
      obscureText: false,
      obscuringCharacter: '*',
      animationType: AnimationType.fade,
      validator: (v) {
        if (v!.length < 4) {
          return "Please enter 4 digits.";
        } else {
          return null;
        }
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 50.h,
        fieldWidth: 50.w,
        activeFillColor: Colors.white,
        activeColor: Colors.black,
        disabledColor: Colors.white,
        inactiveColor: Colors.black,
        inactiveFillColor: Colors.white,
        selectedColor: Colors.black,
        selectedFillColor: Colors.white,
      ),
      cursorColor: Colors.black,
      animationDuration: Duration(milliseconds: 300),
      textStyle: TextStyle(fontSize: 20.sp, height: 1.6.h),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      // autovalidateMode: AutovalidateMode.always,
      // errorAnimationController: errorController,
      controller: controller,
      keyboardType: TextInputType.number,
      boxShadows: [
        // BoxShadow(
        //   offset: Offset(0, 1),
        //   color: AppColors.kPrimaryColor,
        //   blurRadius: 10,
        // )
      ],
      onSaved: onSaved,
      onCompleted: (value) {
        // _con.otp = value.toString();

        // debugPrint("${_con.otp}");
      },
      onChanged: (value) {
        // print(value);
        // setState(() {
        //   _con.otp = value.toString();
        // });
      },
      beforeTextPaste: (text) {
        // debugPrint("Allowing to paste $text");
        return true;
      },
    );
  }
}
