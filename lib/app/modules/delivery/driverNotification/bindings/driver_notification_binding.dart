import 'package:get/get.dart';

import '../controllers/driver_notification_controller.dart';

class DriverNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverNotificationController>(
      () => DriverNotificationController(),
    );
  }
}
