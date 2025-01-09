import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mak_life_delivery/app/modules/delivery/deliveryDashboard/controllers/delivery_dashboard_controller.dart';

import '../../../../data/models/get_assigned_order_model.dart';
import '../excel_report_widget/excel_report_generator.dart';

class OrderReportController extends GetxController {

  final deliveryDashboardController = Get.find<DeliveryDashboardController>();

  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime s) => _selectedDate.value = s;

  final Rx<DateTime> _fromDate = DateTime.now().obs;
  DateTime get fromDate => _fromDate.value;
  set fromDate(DateTime date) => _fromDate.value = date;

  final Rx<DateTime> _toDate = DateTime.now().obs;
  DateTime get toDate => _toDate.value;
  set toDate(DateTime date) => _toDate.value = date;


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
    // filterOrdersByAssignDate(DateTime.now());
    filterOrdersByDateRange(fromDate, toDate);
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

  void filterOrdersByDateRange(DateTime fromDate, DateTime toDate) {
    getFilteredOrder = deliveryDashboardController.getAllOrderList.where((order) {
      final orderDate = DateFormat('dd MMM yyyy').parse(order.assignDate.toString());
      return orderDate.isAfter(fromDate.subtract(const Duration(days: 1))) &&
          orderDate.isBefore(toDate.add(const Duration(days: 1)));
    }).toList();
  }

  void downloadReport(BuildContext context) async {
    final fromDate = _fromDate.value; // Replace with selected fromDate
    final toDate = _toDate.value;  // Replace with selected toDate

    // Filter data for the date range
    List<GetAssignedOrderModel> filteredOrders = deliveryDashboardController.getAllOrderList.where((order) {
      final orderDate = DateFormat('dd MMM yyyy').parse(order.assignDate.toString());
      return orderDate.isAfter(fromDate.subtract(const Duration(days: 1))) &&
          orderDate.isBefore(toDate.add(const Duration(days: 1)));
    }).toList();

    // Generate and save the report
    GenerateComplianceReport reportGenerator = GenerateComplianceReport();
    await reportGenerator.generateExcelReport(context, filteredOrders, fromDate, toDate);
  }

}
