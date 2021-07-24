import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureMain{
  static late FlutterSecureStorage secureStorage;

  static initFlutterSecureStorage()
  {
    secureStorage= FlutterSecureStorage();
  }
}