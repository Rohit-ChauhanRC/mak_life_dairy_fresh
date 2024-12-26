import 'package:get/get.dart';

import '../modules/customer/home/bindings/home_binding.dart';
import '../modules/customer/home/views/home_view.dart';
import '../modules/delivery/deliveryDashboard/bindings/delivery_dashboard_binding.dart';
import '../modules/delivery/deliveryDashboard/views/delivery_dashboard_view.dart';
import '../modules/delivery/driverNotification/bindings/driver_notification_binding.dart';
import '../modules/delivery/driverNotification/views/driver_notification_view.dart';
import '../modules/delivery/order/bindings/order_binding.dart';
import '../modules/delivery/order/views/order_view.dart';
import '../modules/delivery/orderDetails/bindings/order_details_binding.dart';
import '../modules/delivery/orderDetails/views/order_details_view.dart';
import '../modules/delivery/settings/bindings/settings_binding.dart';
import '../modules/delivery/settings/views/settings_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/outlet/admin_dashboard/bindings/admin_dashboard_binding.dart';
import '../modules/outlet/admin_dashboard/bindings/admin_dashboard_binding.dart';
import '../modules/outlet/admin_dashboard/views/admin_dashboard_view.dart';
import '../modules/outlet/admin_dashboard/views/admin_dashboard_view.dart';
import '../modules/outlet/outlet_notifications/bindings/outlet_notifications_binding.dart';
import '../modules/outlet/outlet_notifications/views/outlet_notifications_view.dart';
import '../modules/outlet/outlet_order/bindings/outlet_order_binding.dart';
import '../modules/outlet/outlet_order/views/outlet_order_view.dart';
import '../modules/outlet/outline_add_delivery_boy/bindings/outline_add_delivery_boy_binding.dart';
import '../modules/outlet/outline_add_delivery_boy/views/outline_add_delivery_boy_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/verifyPhoneNumber/bindings/verify_phone_number_binding.dart';
import '../modules/verifyPhoneNumber/views/verify_phone_number_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;
  static const INITIAL1 = Routes.ADMIN_DASHBOARD;

  static const INITIAL2 = Routes.HOME;
  static const INITIAL3 = Routes.DELIVERY_DASHBOARD;

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
    GetPage(
      name: _Paths.OUTLET_NOTIFICATIONS,
      page: () => const OutletNotificationsView(),
      binding: OutletNotificationsBinding(),
    ),
    GetPage(
      name: _Paths.OUTLET_ORDER,
      page: () => const OutletOrderView(),
      binding: OutletOrderBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_NOTIFICATION,
      page: () => const DriverNotificationView(),
      binding: DriverNotificationBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.OUTLIE_ADD_DELIVERY_BOY,
      page: () => const OutlieAddDeliveryBoyView(),
      binding: OutlineAddDeliveryBoyBinding(),
    ),
  ];
}
