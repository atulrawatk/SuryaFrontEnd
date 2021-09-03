import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_media_list_controller.dart';

class ChatMediaListView extends GetView<ChatMediaListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatMediaListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChatMediaListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
