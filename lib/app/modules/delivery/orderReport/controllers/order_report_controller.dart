import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mak_life_delivery/app/modules/delivery/deliveryDashboard/controllers/delivery_dashboard_controller.dart';

import '../../../../data/models/get_assigned_order_model.dart';

class OrderReportController extends GetxController {

  final deliveryDashboardController = Get.find<DeliveryDashboardController>();

  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime s) => _selectedDate.value = s;

  final RxList<GetAssignedOrderModel> _getFilteredOrder =
      <GetAssignedOrderModel>[].obs;
  List<GetAssignedOrderModel> get getFilteredOrder =>
      _getFilteredOrder;
  set getFilteredOrder(List<GetAssignedOrderModel> allOrderList) =>
      _getFilteredOrder.assignAll(allOrderList);

  @override
  void onInit() {
    super.onInit();
    deliveryDashboardController.fetchAssignedOrderAPI();
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
    getFilteredOrder = deliveryDashboardController.getAllOrderList
        .where((order) => order.assignDate == formattedDate)
        .toList();
    selectedDate = date;
  }
}
