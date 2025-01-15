import 'package:get/get.dart';

import '../../../../data/services/shared_preference_service.dart';
import '../../../../routes/app_pages.dart';

class SettingsController extends GetxController {

  final sharedPresencesServices = Get.find<SharedPreferenceService>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout(){
    sharedPresencesServices.clear().then((v){
      Get.offAllNamed(Routes.VERIFY_PHONE_NUMBER);
    });
  }

}
