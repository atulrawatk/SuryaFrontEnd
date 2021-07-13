import 'package:get/get.dart';

import 'package:surya/app/modules/home/bindings/home_binding.dart';
import 'package:surya/app/modules/home/views/home_view.dart';
import 'package:surya/app/modules/login/bindings/login_binding.dart';
import 'package:surya/app/modules/login/views/login_view.dart';
import 'package:surya/app/modules/otp/bindings/otp_binding.dart';
import 'package:surya/app/modules/otp/views/otp_view.dart';
import 'package:surya/app/modules/pin/bindings/pin_binding.dart';
import 'package:surya/app/modules/pin/views/pin_view.dart';
import 'package:surya/app/modules/welcome/bindings/welcome_binding.dart';
import 'package:surya/app/modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PIN,
      page: () => PinView(),
      binding: PinBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
  ];
}
