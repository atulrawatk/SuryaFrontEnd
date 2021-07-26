import 'package:get/get.dart';

import 'package:surya/app/modules/confirmPin/bindings/confirm_pin_binding.dart';
import 'package:surya/app/modules/confirmPin/views/confirm_pin_view.dart';
import 'package:surya/app/modules/createPin/bindings/create_pin_binding.dart';
import 'package:surya/app/modules/createPin/views/create_pin_view.dart';
import 'package:surya/app/modules/enterPin/bindings/enter_pin_binding.dart';
import 'package:surya/app/modules/enterPin/views/enter_pin_view.dart';
import 'package:surya/app/modules/home/bindings/home_binding.dart';
import 'package:surya/app/modules/home/views/home_view.dart';
import 'package:surya/app/modules/login/bindings/login_binding.dart';
import 'package:surya/app/modules/login/views/login_view.dart';
import 'package:surya/app/modules/new_chat_list/bindings/new_chat_list_binding.dart';
import 'package:surya/app/modules/new_chat_list/views/new_chat_list_view.dart';
import 'package:surya/app/modules/otp/bindings/otp_binding.dart';
import 'package:surya/app/modules/otp/views/otp_view.dart';
import 'package:surya/app/modules/splash/bindings/splash_binding.dart';
import 'package:surya/app/modules/splash/views/splash_view.dart';
import 'package:surya/app/modules/welcome/bindings/welcome_binding.dart';
import 'package:surya/app/modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

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
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PIN,
      page: () => CreatePinView(),
      binding: CreatePinBinding(),
    ),
    GetPage(
      name: _Paths.ENTER_PIN,
      page: () => EnterPinView(),
      binding: EnterPinBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_PIN,
      page: () => ConfirmPinView(),
      binding: ConfirmPinBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.NEW_CHAT_LIST,
      page: () => NewChatListView(),
      binding: NewChatListBinding(),
    ),
  ];
}
