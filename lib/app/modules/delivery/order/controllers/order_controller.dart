import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh_delivery/app/modules/delivery/deliveryDashboard/controllers/delivery_dashboard_controller.dart';

class OrderController extends GetxController {

  final deliveryDashboardController = Get.find<DeliveryDashboardController>();

  final RxBool _isCompleteOrder = false.obs;
  bool get isCompleteOrder => _isCompleteOrder.value;
  set isCompleteOrder(bool b) => _isCompleteOrder.value = b;

  final RxBool _isOpenOrder = false.obs;
  bool get isOpenOrder => _isOpenOrder.value;
  set isOpenOrder(bool b) => _isOpenOrder.value = b;

  @override
  void onInit() {
    super.onInit();
    isOpenOrder = Get.arguments[0];
    isCompleteOrder = Get.arguments[1];
    deliveryDashboardController.fetchAssignedOrderAPI();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    deliveryDashboardController.getAllOrderSubscription.cancel();
  }


}
