import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pin_controller.dart';

class PinView extends GetView<PinController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PinView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PinView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
