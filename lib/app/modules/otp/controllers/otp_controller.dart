import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:surya/app/data/api/api_helper.dart';
import 'package:surya/app/data/device_services.dart';
import 'package:surya/app/data/models/OTPVerify.dart';
import 'package:surya/app/data/models/basic_user_model.dart';
import 'package:surya/app/data/native_services/firebase_service.dart';
import 'package:surya/app/data/storage/get_storage/otp_verify_get_storage_service.dart';
import 'package:surya/app/global_widgets/loader.dart';
import 'package:surya/app/routes/app_pages.dart';
import 'package:surya/app/utils/strings.dart';
import 'package:surya/app/utils/styles/colors.dart';

class OtpController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>.broadcast();
  TextEditingController otpController = new TextEditingController();
  ApiHelper _apiHelper = ApiHelper();

  //UserModel
  Rx<OtpVerifyModel> userModel=OtpVerifyModel().obs;


  //Timer
  RxInt _timer = 15.obs;
  int get timer => _timer.value;
  set setTimer(int value) {
    _timer.value = value;
  }

  //Push Token Setter Getter
  RxString _pushToken = "".obs;
  String get pushToken => _pushToken.value;
  set setPushToken(String token) {
    _pushToken.value = token;
  }

  //Status for resend otp
  RxBool _resendOtpTimer = false.obs;
  bool get resendOtpTimer => _resendOtpTimer.value;
  set setResendOtpTimer(bool status) => _resendOtpTimer.value = status;

  //Set encrypted number
  RxString _encNumber = "".obs;
  String get encNumber => _encNumber.value;
  set setEncNumber(String num) {
    _encNumber.value = num;
  }

  //OTP Status
  RxInt _otpStatus = 0.obs;
  int get otpStatus => _otpStatus.value;
  set setOtpStatus(int value) => _otpStatus.value = value;

  @override
  void onInit() {
    super.onInit();
    setEncNumber = Get.arguments!=null?Get.arguments:"";
  }

  @override
  void onReady() {
    super.onReady();
    setResendOtpTimer = true;
    timerStart();
  }

  @override
  void onClose() {
    errorController.close();
    setOtpStatus = 0;
  }

  String otpStatusCheck() {
    return otpStatus == 0
        ? AppStrings.confirmBold
        : otpStatus == 1
            ? AppStrings.loading
            : AppStrings.success;
  }

  Color otpButtonCheck() {
    return otpStatus == 0
        ? Get.theme.primaryColor
        : otpStatus == 1
            ? AppColors.grey_500
            : AppColors.green;
  }

  otpVerify() async {
    if (otpController.text.length < 4) {
      Get.snackbar(AppStrings.otp, AppStrings.enterValidOTP,
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else {
      setOtpStatus = 1;
      LoadingOverlay.of().show();
      Map<String, String> body = {
        "phone_number": BasicUserModel.userEncNumber,
        "otp": otpController.text
      };
      await _apiHelper.otpVerify(body: body).then((res) {
        if (res.isOk) {
          OtpVerifyModel otpModel = OtpVerifyModel.fromJson(res.body);

          //Saving OTP model into Get Storage
          OTPVerifyGetStorageService().saveOtpModel(otpModel);
          userModel.value=otpModel;
          setOtpStatus = 2;
          LoadingOverlay.of().hide();
          Get.toNamed(Routes.CREATE_PIN);
          return res;
        } else {
          setOtpStatus = 0;
          LoadingOverlay.of().hide();
          Get.snackbar(AppStrings.mobileVerification, AppStrings.wrongOTP);
          return res;
        }
      }).catchError((error){
        setOtpStatus=0;
      });
      Timer(Duration(seconds: 1), () => setOtpStatus = 0);
    }
  }

  resendOtp() async {
    LoadingOverlay.of().show();
    //Device ID
    String deviceId = await DeviceServices.deviceInfo();

    //Push token
    String pushToken = await FirebaseService.getFirebaseTokenFromNative();
    Map<String, Object> body = {
      "phone_number": BasicUserModel.userEncNumber,
      "device_id": deviceId,
      "push_token": pushToken
    };

    await _apiHelper.resendOtp(body: body).then((res) {
      LoadingOverlay.of().hide();
      if (res.isOk) {
        Timer(Duration(milliseconds: 300),
            () => Get.snackbar(AppStrings.otp, AppStrings.otpSentSuccessfully));
        //setEncNumber=phoneNumEncrypted;
      } else {
        Get.snackbar(
            AppStrings.mobileVerification, AppStrings.somethingWentWrong);
        //  Future.error("Sign in Error");
      }
    });
  }

  String timerString() {
    if (timer < 10) {
      return " 00:0" + timer.toString();
    } else {
      return " 00:" + timer.toString();
    }
  }

  timerStart() {
    if (timer == 0) {
      setResendOtpTimer = false;
      setTimer = 15;
      return "";
    }
    Timer(Duration(seconds: 1), () {
      setTimer = timer - 1;
      timerStart();
    });
  }
}
