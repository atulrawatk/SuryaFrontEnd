import 'package:get/get.dart';

import '../controllers/new_group_name_chat_controller.dart';

class NewGroupNameChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewGroupNameChatController>(
      () => NewGroupNameChatController(),
    );
  }
}
