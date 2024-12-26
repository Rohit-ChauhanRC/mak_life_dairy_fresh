import 'package:get/get.dart';

import '../controllers/outline_add_delivery_boy_controller.dart';

class OutlineAddDeliveryBoyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutlineAddDeliveryBoyController>(
      () => OutlineAddDeliveryBoyController(),
    );
  }
}
