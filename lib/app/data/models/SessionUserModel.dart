import 'package:get/get.dart';

class SessionUserModel{

  //Initializing User Instances
  static RxString _userId="".obs;
  static RxString _sessionToken="".obs;

  //Getters for User Model

  static String get sessionToken=>_sessionToken.value;
  static String get userId=>_userId.value;

  //Setters for User Model
  static set setSessionToken(String token){
    _sessionToken.value=token;
  }

  static set setUserId(String id){
    _userId.value=id;
  }
}