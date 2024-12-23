import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/modules/customer/home/controllers/home_controller.dart';
import 'package:mak_life_dairy_fresh/app/modules/landing/controllers/landing_controller.dart';
import 'package:mak_life_dairy_fresh/app/modules/otp/controllers/otp_controller.dart';
import 'package:mak_life_dairy_fresh/app/modules/verifyPhoneNumber/controllers/verify_phone_number_controller.dart';

import 'app/data/services/shared_preference_service.dart';

init() async {
  Get.lazyPut(() => SharedPreferenceService());
  Get.lazyPut(() => LandingController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => VerifyPhoneNumberController());
  Get.lazyPut(() => OtpController());
  // Get.lazyPut(() => ConnectivityService());
  final sharedPreferenceService = Get.find<SharedPreferenceService>();
  await sharedPreferenceService.init();
}
