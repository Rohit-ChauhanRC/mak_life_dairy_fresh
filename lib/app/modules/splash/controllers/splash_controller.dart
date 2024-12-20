import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/constants/constants.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';

class SplashController extends GetxController {
  final sharedPreferenceService = Get.find<SharedPreferenceService>();

  @override
  void onInit() {
    // sharedPreferenceService.setBool(createUserProfile, true);
    // sharedPreferenceService.setBool(isNumVerify, false);
    navigateToHome();
    super.onInit();
  }

  bool? getIsNumVerified() {
    return sharedPreferenceService.getBool(isNumVerify);
  }

  bool? getIscreateUserProfile() {
    return sharedPreferenceService.getBool(createUserProfile);
  }

  void navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    bool? isVerified = getIsNumVerified();
    bool? isCreatedUserProfile = getIscreateUserProfile();
    if (isVerified == true) {
      // Get.offNamed(Routes.CREATE_PROFILE, arguments: false);
    } else if (isCreatedUserProfile == true) {
      // Get.put(ChatsController());
      // Get.offNamed(Routes.HOME);
    } else {
      // Get.offNamed(Routes.LANDING);
    }
  }
}
