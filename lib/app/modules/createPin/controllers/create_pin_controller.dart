import 'dart:async';
import 'package:get/get.dart';
import 'package:surya/app/data/storage/flutter_secure/pin.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/strings.dart';

class CreatePinController extends GetxController {
 RxString _pinInfo=AppStrings.createYourPin.obs;
 RxBool _createStatus=false.obs;
 bool get createStatus=>_createStatus.value;
 set setCreateStatus(bool status){
  _createStatus.value=status;
 }
 String get pinInfo=>_pinInfo.value;
 set setPinInfo(String str){
    _pinInfo.value=str;
    update();
 }
 final StreamController<bool> verificationNotifier = StreamController<bool>.broadcast();
 RxString _pin="".obs;
 String get pin=>_pin.value;
 set setPin(String str){
   _pin.value=_pin.value+str;
 }
  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
  }
  @override
  void onClose() {
   verificationNotifier.close();
  }


  //Here we are creating pin
  createPin(String pin){
  Get.offAndToNamed(Routes.CONFIRM_PIN,arguments: pin);
  }
}
