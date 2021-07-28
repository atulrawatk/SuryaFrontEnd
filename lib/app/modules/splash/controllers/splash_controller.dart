import 'package:get/get.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/strings.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(
      Duration(seconds: 2),
      () {
        Get.offAndToNamed(
          AppGetStorage.hasData(AppStrings.isLogin) ? Routes.ENTER_PIN :
          Routes.WELCOME,
        );
      },
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
}
