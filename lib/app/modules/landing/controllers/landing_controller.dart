import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh_delivery/app/routes/app_pages.dart';

class LandingController extends GetxController {
//
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    gotohome();

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void gotohome() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    Get.offNamed(Routes.VERIFY_PHONE_NUMBER);
  }
}
