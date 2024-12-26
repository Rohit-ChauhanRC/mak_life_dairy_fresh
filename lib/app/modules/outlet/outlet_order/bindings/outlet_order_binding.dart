import 'package:get/get.dart';

import '../controllers/outlet_order_controller.dart';

class OutletOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutletOrderController>(
      () => OutletOrderController(),
    );
  }
}
