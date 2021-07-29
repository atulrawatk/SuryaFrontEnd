import 'package:get/get.dart';
import 'package:surya/app/global_widgets/loader.dart';
import 'package:surya/app/utils/network/api_constant.dart';
import 'package:surya/app/utils/network/network_connection.dart';
import 'package:surya/app/utils/strings.dart';

class ApiHelper extends GetConnect with NetworkConnection {
  ApiHelper._();
 factory ApiHelper(){
   return ApiHelper._();
 }
  static Map<String, String> normalHeader = {
    'Content-Type': 'application/json'
  };
   Map<String, String> tokenHeader({required String token}) {
   return{
     'Content-Type': 'application/json',
     'Authorization':token
   };
  }

//Basic Api for network checking and hitting api
  Future<Response> checkInternetWithApi(
      {required Future<Response> requestType}) async {
    return await NetworkConnection().checkInternetConnection().then((value) {
      if (!value) {
        LoadingOverlay.of().hide();
        Get.snackbar(AppStrings.appName, AppStrings.internetProblem);
        return Future.error(AppStrings.internetProblem);
      } else {
        return requestType;
      }
    });
  }


  // Login API
  Future<Response> login({
    required Map<dynamic, dynamic> body,
  }) async {
    return await checkInternetWithApi(
            requestType: post(ApiConstant.baseUrl + ApiConstant.login, body,
                headers: normalHeader))
        .catchError((error) {});
  }

  //Otp Verify API
  Future<Response> otpVerify({required Map<dynamic, dynamic> body}) async {
    return await checkInternetWithApi(
        requestType: post(ApiConstant.baseUrl + ApiConstant.otpVerify, body,
            headers: normalHeader)).catchError((error) {});
  }

  //Resend Otp
  Future<Response> resendOtp({
    required Map<dynamic, dynamic> body,
  }) {
    return checkInternetWithApi(requestType: post(ApiConstant.baseUrl + ApiConstant.login, body,
        headers: normalHeader)).catchError((error) {});
  }

  //
  //Threads APIs
  //


  Future<Response> getUserThreads({
    required String? userId,
    required String? authToken
  }) async {
    return await checkInternetWithApi(
        requestType: get(ApiConstant.baseUrl + ApiConstant.getThreads+userId!+"/",
            headers:tokenHeader(token: authToken!) ))
        .catchError((error) {});
  }
}
