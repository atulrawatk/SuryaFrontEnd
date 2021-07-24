import 'package:get/get.dart';
import 'package:surya/app/utils/network/api_constant.dart';
import 'package:surya/app/utils/network/network_connection.dart';
import 'package:surya/app/utils/strings.dart';

class ApiHelper extends GetConnect with NetworkConnection {
  ApiHelper() {
    internetCheck();
  }
  static Map<String, String> normalHeader = {
    'Content-Type': 'application/json'
  };

  internetCheck() {
    NetworkConnection().checkInternetConnection().then((value) {
      if (!value) {
        Get.snackbar(AppStrings.appName, AppStrings.internetProblem);
      }
    });
  }

  Future<Response?> basicApi(
      {required Map<dynamic, dynamic> body,
      required Future<Response> requestType}) {
    return NetworkConnection().checkInternetConnection().then((value) {
      if (value) {
        return requestType;
      } else {
        Get.snackbar(AppStrings.appName, AppStrings.internetProblem);
        return Future.error(AppStrings.error);
      }
    });
  }

  // Login API
  Future<Response?> login({
    required Map<dynamic, dynamic> body,
  }) {
    // return basicApi(body: body, requestType: post(ApiConstant.baseUrl+ApiConstant.login, body,headers: normalHeader));
    return post(ApiConstant.baseUrl + ApiConstant.login, body,
        headers: normalHeader);
  }

  //Otp Verify API
  Future<Response> otpVerify({required Map<dynamic, dynamic> body}) {
    return post(ApiConstant.baseUrl + ApiConstant.otpVerify, body,
        headers: normalHeader);
  }

  //Resend Otp
  Future<Response> resendOtp({
    required Map<dynamic, dynamic> body,
  }) {
    return post(ApiConstant.baseUrl + ApiConstant.login, body,
        headers: normalHeader);
  }
}
