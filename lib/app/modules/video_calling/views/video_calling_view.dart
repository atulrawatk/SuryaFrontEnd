import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/video_calling_controller.dart';

class VideoCallingView extends GetView<VideoCallingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VideoCallingView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'VideoCallingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
