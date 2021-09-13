import 'dart:async';

import 'package:get/get.dart';
import 'package:surya/app/data/storage/flutter_secure/pin.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/strings.dart';

class ConfirmPinController extends GetxController {

  final StreamController<bool> verificationNotifier = StreamController<bool>.broadcast();
  RxString _myPrevPin="".obs;
  String get myPrevPin=>_myPrevPin.value;
  set setMyPrevPin(String pin){
    _myPrevPin.value=pin;
  }
  confirmPin(String pin){
    if(pin==myPrevPin){
      PinStorage().setScreenPin(pin);
      Get.offAllNamed(Routes.CREATE_USER_NAME);
    }
    else{
      Get.snackbar(AppStrings.screenPin, AppStrings.wrongPin);
    }
  }
  @override
  void onInit() {
    super.onInit();
    setMyPrevPin=Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    verificationNotifier.close();
  }
}
