import 'package:get/get.dart';

import '../controllers/new_group_controller.dart';

class NewGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewGroupController>(
      () => NewGroupController(),
    );
  }
}
