import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh_delivery/app/data/repos/delivery_order_repo.dart';
// import 'package:mak_life_dairy_fresh/app/modules/customer/home/controllers/home_controller.dart';
import 'package:mak_life_dairy_fresh_delivery/app/modules/delivery/deliveryDashboard/controllers/delivery_dashboard_controller.dart';
import 'package:mak_life_dairy_fresh_delivery/app/modules/delivery/orderDetails/controllers/order_details_controller.dart';
import 'package:mak_life_dairy_fresh_delivery/app/modules/landing/controllers/landing_controller.dart';
import 'package:mak_life_dairy_fresh_delivery/app/modules/otp/controllers/otp_controller.dart';
import 'package:mak_life_dairy_fresh_delivery/app/modules/verifyPhoneNumber/controllers/verify_phone_number_controller.dart';

import 'app/data/repos/auth_repo.dart';
import 'app/data/services/api_service.dart';
import 'app/data/services/shared_preference_service.dart';

init() async {
  // Initialize SharedPreferenceService
  final sharedPreferenceService = SharedPreferenceService();
  await sharedPreferenceService.init();
  Get.put(sharedPreferenceService);

  // Initialize ApiService
  Get.lazyPut(() => ApiService());

  // Initialize Repositories
  Get.lazyPut(() => AuthRepository(apiService: Get.find<ApiService>(), sharedPreferences: Get.find<SharedPreferenceService>()));

  Get.lazyPut(() => DeliveryOrderRepository(sharedPresenceServices: Get.find<SharedPreferenceService>(), apiService: Get.find<ApiService>()));

  // Initialize Controllers
  Get.lazyPut(() => LandingController());
  // Get.lazyPut(() => HomeController());
  Get.lazyPut(() => VerifyPhoneNumberController(authRepository: Get.find<AuthRepository>()));
  Get.lazyPut(() => OtpController(authRepository: Get.find<AuthRepository>()));
  Get.lazyPut(() => DeliveryDashboardController(deliveryOrderRepository: Get.find<DeliveryOrderRepository>()));
  Get.lazyPut(() => OrderDetailsController(deliveryOrderRepository: Get.find<DeliveryOrderRepository>()));
  // Get.lazyPut(() => ConnectivityService());
}
