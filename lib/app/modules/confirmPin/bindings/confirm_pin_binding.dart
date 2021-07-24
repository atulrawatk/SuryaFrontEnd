import 'package:get/get.dart';

import '../controllers/confirm_pin_controller.dart';

class ConfirmPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmPinController>(
      () => ConfirmPinController(),
    );
  }
}
