import 'dart:async';

import 'package:get/get.dart';
import 'package:surya/app/data/storage/flutter_secure/pin.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/strings.dart';

class EnterPinController extends GetxController {
  final StreamController<bool> verificationNotifier = StreamController<bool>.broadcast();

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

  enterPin(String pin) async{
    await PinStorage().getScreenPin().then((storedPin) {
      if(storedPin==pin){
        Get.offAndToNamed(Routes.HOME);
      }
      else{
        Get.snackbar(AppStrings.screenPin, AppStrings.wrongPin);
      }
    }
    );
  }
}
