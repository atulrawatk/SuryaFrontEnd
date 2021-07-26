import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_chat_list_controller.dart';

class NewChatListView extends GetView<NewChatListController> {
  @override
  Widget build(BuildContext context) {
    // controller.onReady();
    return Scaffold(
      appBar: AppBar(
        title: Text('NewChatListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NewChatListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
