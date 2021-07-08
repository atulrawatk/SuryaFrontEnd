import 'package:flutter/material.dart';
import 'package:surya/app/utils/styles/dimens.dart';

class PinNumberDigit extends StatelessWidget {
  final String pin;
  const PinNumberDigit({
    required Key key,required this.pin
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(24),
      child: Text(
        pin,
        style: TextStyle(
          fontSize: AppDimensions.bigHeadingSize,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
