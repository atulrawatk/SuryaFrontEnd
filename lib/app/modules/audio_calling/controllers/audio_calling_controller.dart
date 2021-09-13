import 'package:get/get.dart';
import 'package:surya/app/data/models/call_d_b_model.dart';

class AudioCallingController extends GetxController {
  //TODO: Implement AudioCallingController

  RxBool isMute=false.obs;
  RxBool isVideoOn=false.obs;
  RxBool isSpeakerOn=false.obs;
  late CallDBModel callModel;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    callModel=Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
