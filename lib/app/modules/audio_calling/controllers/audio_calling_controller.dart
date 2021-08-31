import 'package:get/get.dart';

class AudioCallingController extends GetxController {
  //TODO: Implement AudioCallingController

  RxBool isMute=false.obs;
  RxBool isVideoOn=false.obs;
  RxBool isSpeakerOn=false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
