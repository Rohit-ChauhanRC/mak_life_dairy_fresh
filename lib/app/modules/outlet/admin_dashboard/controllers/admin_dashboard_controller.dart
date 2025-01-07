import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/constants/constants.dart';
import 'package:mak_life_dairy_fresh/app/data/models/assigned_order_outlet.dart';
import 'package:mak_life_dairy_fresh/app/data/models/delivered_order_outlet.dart';
import 'package:mak_life_dairy_fresh/app/data/models/driver_outlet_model.dart';
import 'package:mak_life_dairy_fresh/app/data/models/new_order_outlet_model.dart';
import 'package:mak_life_dairy_fresh/app/data/models/verified_order_outlet.dart';
import 'package:mak_life_dairy_fresh/app/data/repos/outlet_repo.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';
import 'package:mak_life_dairy_fresh/app/utils/app_enums/order_enum.dart';

class AdminDashboardController extends GetxController {
  //

  final OutletRepo outletRepo;
  AdminDashboardController({required this.outletRepo});

  final sharedPreferenceService = Get.find<SharedPreferenceService>();

  final Rx<OrderEnum> _orderStatus = OrderEnum.preparing.obs;
  OrderEnum get orderStatus => _orderStatus.value;
  set orderStatus(OrderEnum lst) => _orderStatus.value = lst;

  final RxList<NewOrderOutletModel?> newOrder = <NewOrderOutletModel?>[].obs;
  final RxList<VerifiedOrderDetailOutletModel?> verifiedOrder =
      <VerifiedOrderDetailOutletModel?>[].obs;
  final RxList<AssignedOrderDetailOutletModel?> assignedOrder =
      <AssignedOrderDetailOutletModel?>[].obs;

  final RxList<DeliveredOrderModel?> deliveredOrder =
      <DeliveredOrderModel?>[].obs;

  final RxList<DriverListModel?> driverList = <DriverListModel?>[].obs;

  var selectedBoy = Rxn<DriverListModel>();

  late StreamSubscription<List<NewOrderOutletModel>> newOrderSubscription;
  late StreamSubscription<List<VerifiedOrderDetailOutletModel>>
      verifyOrderSubscription;
  late StreamSubscription<List<AssignedOrderDetailOutletModel>>
      assignedOrderSubscription;

  late StreamSubscription<List<DeliveredOrderModel>> deliveredOrderSubscription;

  late StreamSubscription<List<DriverListModel>> driverListSubscription;

  final RxList<String> _listOfIds = <String>[].obs;
  List<String> get listOfIds => _listOfIds;
  set listOfIds(List<String> lst) => _listOfIds.assignAll(lst);

  final RxList<String> _deliveryIds = <String>[].obs;
  List<String> get deliveryIds => _deliveryIds;
  set deliveryIds(List<String> lst) => _deliveryIds.assignAll(lst);

  final orderList = [
    OrderEnum.preparing,
    OrderEnum.approved,
    OrderEnum.assigned,
    OrderEnum.completed,
    OrderEnum.cancel
  ];

  final RxBool refreshVerifiedOrder = false.obs;
  final RxBool assigningDeliveryOrder = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchdata();
    fetchVerifiedOrderData();
    fetchAssignedOrderData();
    fetchDeliveredOrderData();
    fetchDriverListData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    newOrderSubscription.cancel();
    verifyOrderSubscription.cancel();
    deliveredOrderSubscription.cancel();
    assignedOrderSubscription.cancel();
    deliveredOrderSubscription.cancel();
    driverListSubscription.cancel();
    newOrder.clear();
    assignedOrder.close();
    deliveredOrder.close();
    verifiedOrder.close();
    _listOfIds.close();
    driverList.close();
    driverListSubscription.cancel();
    super.onClose();
  }

  void selectDeliveryBoy(String id) {
    // selectedBoy.value = boy; // Update the selected delivery boy
    deliveryIds.assign(id);
    debugPrint("boys: $id");
  }

  void fetchdata() {
    // newOrder.bindStream(
    newOrderSubscription = outletRepo.apiService
        .fetchNewOrderStream<NewOrderOutletModel>(
            endpoint: '/api/ViewOrderList',
            fromJson: (json) => NewOrderOutletModel.fromJson(json),
            query: {
          "OutletId": sharedPreferenceService.getString(outletId)
        }).listen((data) {
      newOrder.assignAll(data);
    });
  }

  void fetchVerifiedOrderData() async {
    refreshVerifiedOrder.value = true;
    final response = await outletRepo.verifyOrdersListForAssigning(
        sharedPreferenceService.getString(userUId)!);
    if (response != null && response.statusCode == 200) {
      List<VerifiedOrderDetailOutletModel> data =
          List<VerifiedOrderDetailOutletModel>.from(
        response.data.map((x) => VerifiedOrderDetailOutletModel.fromJson(x)),
      );
      refreshVerifiedOrder.value = false;
      verifiedOrder.assignAll(data);
    }
  }

  void fetchAssignedOrderData() {
    // newOrder.bindStream(/api/VViewAssignOrderlistStatus/ViewOrderListByUser
    assignedOrderSubscription = outletRepo.apiService
        .fetchNewOrderStream<AssignedOrderDetailOutletModel>(
            endpoint: '/api/ViewAssignedOrders',
            fromJson: (json) => AssignedOrderDetailOutletModel.fromJson(json),
            query: {
          "UserId": sharedPreferenceService.getString(userUId)
        }).listen((data) {
      assignedOrder.assignAll(data);
    });
  }

  void fetchDeliveredOrderData() {
    deliveredOrderSubscription = outletRepo.apiService
        .fetchNewOrderStream<DeliveredOrderModel>(
            endpoint: '/api/DeliveredList',
            fromJson: (json) => DeliveredOrderModel.fromJson(json),
            query: {
          "UserId": sharedPreferenceService.getString(userUId)
        }).listen((data) {
      deliveredOrder.assignAll(data);
    });
  }

  void fetchDriverListData() {
    driverListSubscription = outletRepo.apiService
        .fetchNewOrderStream<DriverListModel>(
            endpoint: '/api/DeliveryList',
            fromJson: (json) => DriverListModel.fromJson(json),
            query: {
          "outletId": sharedPreferenceService.getString(outletId)
        }).listen((data) {
      driverList.assignAll(data);
    });
  }

  void toggleCheckbox(int index, bool value) {
    verifiedOrder.reversed.toList()[index]!.isChecked.value = value;
    if (listOfIds.contains(verifiedOrder.reversed.toList()[index]!.orderId)) {
      listOfIds.remove(verifiedOrder.reversed.toList()[index]!.orderId);
    } else {
      listOfIds.add(verifiedOrder.reversed.toList()[index]!.orderId.toString());
    }
  }

  void assigningDeliveryBoyOnOrder(String deliveryBoyId) async {
    assigningDeliveryOrder.value = true;
    for (var a in listOfIds) {
      debugPrint("vijay: $a");
    }

    final response = await outletRepo.orderAssigningDeliveryBoy(
        orderIds: listOfIds,
        userId: sharedPreferenceService.getString(userUId)!,
        deliveryBoyId: deliveryBoyId,
        outletId: sharedPreferenceService.getString(outletId)!);

    final a = response?.data.toString();
    if (response != null &&
        response.statusCode == 200 &&
        a == "Order assigned to delivery successfully !") {
      deliveryIds = [];
      deliveryIds.clear();
      listOfIds.clear();
      fetchVerifiedOrderData();
    }
    assigningDeliveryOrder.value = false;
  }
}
