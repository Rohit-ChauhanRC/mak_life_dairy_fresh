import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/modules/landing/bindings/landing_binding.dart';
import 'package:mak_life_dairy_fresh/app/modules/landing/views/landing_view.dart';
import 'package:mak_life_dairy_fresh/app/modules/otp/bindings/otp_binding.dart';
import 'package:mak_life_dairy_fresh/app/modules/otp/views/otp_view.dart';
import 'package:mak_life_dairy_fresh/app/modules/splash/bindings/splash_binding.dart';
import 'package:mak_life_dairy_fresh/app/modules/splash/views/splash_view.dart';
import 'package:mak_life_dairy_fresh/app/modules/verifyPhoneNumber/bindings/verify_phone_number_binding.dart';
import 'package:mak_life_dairy_fresh/app/modules/verifyPhoneNumber/views/verify_phone_number_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;
  static const INITIAL2 = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_PHONE_NUMBER,
      page: () => const VerifyPhoneNumberView(),
      binding: VerifyPhoneNumberBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
  ];
}
