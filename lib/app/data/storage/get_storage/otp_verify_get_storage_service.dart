import 'package:surya/app/data/models/OTPVerify.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/data/storage/get_storage/get_storage_keys.dart';
import 'dart:convert' as JSON;

class OTPVerifyGetStorageService{

   OTPVerifyGetStorageService._();
  factory OTPVerifyGetStorageService(){
    return OTPVerifyGetStorageService._();
  }
   saveOtpModel(OtpVerifyModel model){
    AppGetStorage.saveValue(GetStorageKeys.otpVerifyModelKey, model);
  }
   Future<OtpVerifyModel> getOtpModel() async{
    var model= OtpVerifyModel.fromJson(AppGetStorage.getValue(GetStorageKeys.otpVerifyModelKey));
   return model;
  }
}