import 'package:get/get.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeController extends GetxController {
  void launchURL() async =>
      await canLaunch(AppStrings.privacyUrl) ? await launch(AppStrings.privacyUrl) : throw 'Could not launch $AppStrings.privacyUrl';
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
    super.onClose();
  }
}
