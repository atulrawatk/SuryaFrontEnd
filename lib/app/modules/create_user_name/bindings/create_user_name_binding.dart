import 'package:get/get.dart';

import '../controllers/create_user_name_controller.dart';

class CreateUserNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUserNameController>(
      () => CreateUserNameController(),
    );
  }
}
