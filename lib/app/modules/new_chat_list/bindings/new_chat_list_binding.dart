import 'package:get/get.dart';

import '../controllers/new_chat_list_controller.dart';

class NewChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NewChatListController>(NewChatListController());
  }
}
