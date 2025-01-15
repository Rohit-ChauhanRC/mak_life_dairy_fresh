import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mak_life_delivery/app/modules/delivery/deliveryDashboard/controllers/delivery_dashboard_controller.dart';

import '../../../../data/models/get_assigned_order_model.dart';

class OrderController extends GetxController {
  final deliveryDashboardController = Get.find<DeliveryDashboardController>();

  final RxBool _isCompleteOrder = false.obs;
  bool get isCompleteOrder => _isCompleteOrder.value;
  set isCompleteOrder(bool b) => _isCompleteOrder.value = b;

  final RxBool _isOpenOrder = false.obs;
  bool get isOpenOrder => _isOpenOrder.value;
  set isOpenOrder(bool b) => _isOpenOrder.value = b;

  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime s) => _selectedDate.value = s;

  final RxList<GetAssignedOrderModel> _getFilteredCompletedOrder =
      <GetAssignedOrderModel>[].obs;
  List<GetAssignedOrderModel> get getFilteredCompletedOrder =>
      _getFilteredCompletedOrder;
  set getFilteredCompletedOrder(List<GetAssignedOrderModel> allOrderList) =>
      _getFilteredCompletedOrder.assignAll(allOrderList);

  @override
  void onInit() {
    super.onInit();
    isOpenOrder = Get.arguments[0];
    isCompleteOrder = Get.arguments[1];
    deliveryDashboardController.fetchAssignedOrderAPI();
    deliveryDashboardController.getCurrentLocation();
    filterOrdersByAssignDate(DateTime.now());
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

  /// Filters the completed orders by `AssignDate`.
  void filterOrdersByAssignDate(DateTime date) {
    final formattedDate =
        DateFormat('dd MMM yyyy').format(date); // Format selected date
    getFilteredCompletedOrder = deliveryDashboardController.getCompletedOrder
        .where((order) => order.assignDate == formattedDate)
        .toList();
    selectedDate = date;
  }
}
