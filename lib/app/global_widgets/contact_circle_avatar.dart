import 'package:flutter/material.dart';
import 'global_widgets.dart';
class ContactCircleAvatar extends StatelessWidget {
  final String imageUrl;
  const ContactCircleAvatar({Key? key,
    required this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 55.h,
      width: 55.h,
      child: CircleAvatar(
        radius: 30.r,
        backgroundImage: Image.asset(imageUrl,fit: BoxFit.fill,).image
      ),
    );
  }
}
