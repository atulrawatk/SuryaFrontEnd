import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        fixedSize: Size(
          Get.width / 2,
          50,
        ),
      ),
      onPressed: () {},
      child: Text('Login'),
    );
  }
}
