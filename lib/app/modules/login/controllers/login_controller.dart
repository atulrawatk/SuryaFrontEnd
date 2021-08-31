
import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:surya/app/data/api/api_helper.dart';
import 'package:surya/app/data/device_services.dart';
import 'package:surya/app/data/encryption/aes.dart';
import 'package:surya/app/data/models/basic_user_model.dart';
import 'package:surya/app/data/models/send_otp_model.dart';
import 'package:surya/app/data/native_services/firebase_service.dart';
import 'package:surya/app/data/storage/get_storage/get_storage.dart';
import 'package:surya/app/data/storage/get_storage/get_storage_keys.dart';
import 'package:surya/app/global_widgets/loader.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/network/network_connection.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/dot_env_controller.dart';

class LoginController extends GetxController {
  //API Helper Instance for login purpose
  ApiHelper _apiHelper=ApiHelper();

  AESEncryption _aesEncryption=AESEncryption();

   GlobalKey<FormState> loginKey=GlobalKey<FormState>();

  final TextEditingController mobileController=new TextEditingController();
  RxString _encNumber="".obs;
  String get encNumber=>_encNumber.value;
  set setEncNumber(String num){
    _encNumber.value=num;
  }



 signIn() async{
    if(mobileController.text.length<10){
      Get.snackbar(AppStrings.mobileVerification, AppStrings.enterValidNumber,snackPosition: SnackPosition.BOTTOM);
      return;
    }
    else{
     bool internetCheck= await  NetworkConnection().checkInternetConnection();
      if(internetCheck){
        LoadingOverlay.of().show();
        //Device ID
        String deviceId= await DeviceServices.deviceInfo();
        print(deviceId);
        //2cdab9c0dbebfe3f

        //Firebase Push token
        String pushToken= await FirebaseService.getFirebaseTokenFromNative();

        //Phone Number Encrypt
        String phoneNumEncrypted=_aesEncryption.encryptAESFull(plainText: mobileController.value.text);

        Map<String,Object> body={
          "phone_number":phoneNumEncrypted,
          "device_id":deviceId,
          "push_token":pushToken
        };

        await _apiHelper.login(body: body).then((res) {
          LoadingOverlay.of().hide();
          if(res.isOk){
            SendOtpModel userModel=SendOtpModel.fromJson(res.body);

            //Setting User Id and Token
            BasicUserModel.userId=userModel.success!.data!.id!;
            BasicUserModel.userEncNumber=phoneNumEncrypted;
            BasicUserModel.userToken=userModel.success!.data!.verificationToken!;

            Timer(Duration(milliseconds: 300),()=>Get.snackbar(AppStrings.otp, AppStrings.otpSentSuccessfully));
            Get.toNamed(Routes.OTP);
            //setEncNumber=phoneNumEncrypted;
          }
          else{
            //   Get.showSnackbar(GetBar(message: "Gooooooo",isDismissible: true,duration: Duration(seconds: 1),));
            Get.snackbar(AppStrings.mobileVerification, AppStrings.userNotExist,snackPosition: SnackPosition.BOTTOM);
            //  Future.error("Sign in Error");
          }
        }).catchError((error){
          // Get.back();
          //
        });
      }
      else{
        Get.snackbar(AppStrings.appName, AppStrings.internetProblem);
      }


    }
 }
  @override
  Future<void> onInit() async {
    super.onInit();
    loginKey = GlobalKey<FormState>();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    mobileController.dispose();
  }
}
