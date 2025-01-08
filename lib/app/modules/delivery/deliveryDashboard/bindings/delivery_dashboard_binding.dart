import 'package:get/get.dart';
import 'package:mak_life_delivery/app/data/services/api_service.dart';
import 'package:mak_life_delivery/app/data/services/shared_preference_service.dart';

import '../../../../data/repos/delivery_order_repo.dart';
import '../controllers/delivery_dashboard_controller.dart';

class DeliveryDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SharedPreferenceService());
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => DeliveryOrderRepository(sharedPresenceServices: Get.find<SharedPreferenceService>(), apiService: Get.find<ApiService>()));
    Get.lazyPut(() => DeliveryDashboardController(deliveryOrderRepository: Get.find<DeliveryOrderRepository>()));
    Get.find<DeliveryDashboardController>();
  }
}
