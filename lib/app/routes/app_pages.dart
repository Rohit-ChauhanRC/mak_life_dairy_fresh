import 'package:get/get.dart';

import '../modules/customer/home/bindings/home_binding.dart';
import '../modules/customer/home/views/home_view.dart';
import '../modules/delivery/deliveryDashboard/bindings/delivery_dashboard_binding.dart';
import '../modules/delivery/deliveryDashboard/views/delivery_dashboard_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/outlet/admin_dashboard/bindings/admin_dashboard_binding.dart';
import '../modules/outlet/admin_dashboard/views/admin_dashboard_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/verifyPhoneNumber/bindings/verify_phone_number_binding.dart';
import '../modules/verifyPhoneNumber/views/verify_phone_number_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ADMIN_DASHBOARD;
  // static const INITIAL = Routes.DELIVERY_DASHBOARD;
  // static const INITIAL = Routes.LANDING;
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
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY_DASHBOARD,
      page: () => const DeliveryDashboardView(),
      binding: DeliveryDashboardBinding(),
    ),
  ];
}
