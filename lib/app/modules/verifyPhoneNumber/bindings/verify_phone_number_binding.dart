import 'package:get/get.dart';

import '../../../data/repos/auth_repo.dart';
import '../../../data/services/api_service.dart';
import '../controllers/verify_phone_number_controller.dart';

class VerifyPhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>ApiService());
    Get.lazyPut(() => AuthRepository(apiService: Get.find(), sharedPreferences: Get.find()));
    Get.lazyPut<VerifyPhoneNumberController>(
      () => VerifyPhoneNumberController(authRepository: Get.find()),
    );
  }
}
