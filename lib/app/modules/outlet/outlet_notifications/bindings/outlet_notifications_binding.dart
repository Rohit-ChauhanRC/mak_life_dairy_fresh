import 'package:get/get.dart';

import '../controllers/outlet_notifications_controller.dart';

class OutletNotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutletNotificationsController>(
      () => OutletNotificationsController(),
    );
  }
}
