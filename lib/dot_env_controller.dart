import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvController extends GetxController {
  DotEnvController._();

  factory DotEnvController()=>DotEnvController._();
  //
  final RxString _appUrl = RxString('');
  String get appUrl => this._appUrl.value;
  set appUrl(String? text) => this._appUrl.value = text!;

  final RxString _webUrl = RxString('');
  String get webUrl => this._webUrl.value;
  set webUrl(String? text) => this._webUrl.value = text!;

  final RxString _encryptKey = RxString('');
  String get encryptKey => this._encryptKey.value;
  set encryptKey(String? text) => this._encryptKey.value = text!;

  final RxString _encryptIv = RxString('');
  String get encryptIv => this._encryptIv.value;
  set encryptIv(String? text) => this._encryptIv.value = text!;

  @override
  void onInit() {
    super.onInit();
    appUrl = dotenv.env["APP_URL"];
    webUrl = dotenv.env["WEB_URL"];
    encryptKey = dotenv.env["ENCRYPT_KEY"];
    encryptIv = dotenv.env["ENCRYPT_IV"];
    print("app url: $appUrl");
    print("webUrl : $webUrl");
    print("encryptKey: $encryptKey");
    print("encryptIv: $encryptIv");
  }
}
