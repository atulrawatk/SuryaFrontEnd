import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:surya/dot_env_controller.dart';

class InjectionClass {
  static void constcall() {
    Get.put(
      DotEnvController(),
    );
  }
}
