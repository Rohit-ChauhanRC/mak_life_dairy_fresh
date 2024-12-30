import 'package:get/get.dart';

import '../controllers/delivery_dashboard_controller.dart';

class DeliveryDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<DeliveryDashboardController>();
  }
}
