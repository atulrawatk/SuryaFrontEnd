import 'package:get/get.dart';

import '../controllers/chat_media_list_controller.dart';

class ChatMediaListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatMediaListController>(
      () => ChatMediaListController(),
    );
  }
}
