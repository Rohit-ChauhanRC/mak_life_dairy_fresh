import 'package:get/get.dart';

import '../controllers/outlet_profile_controller.dart';

class OutletProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutletProfileController>(
      () => OutletProfileController(),
    );
  }
}
