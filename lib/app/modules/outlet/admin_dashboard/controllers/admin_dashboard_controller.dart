import 'dart:async';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/constants/constants.dart';
import 'package:mak_life_dairy_fresh/app/data/models/assigned_order_outlet.dart';
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

  late StreamSubscription<List<NewOrderOutletModel>> newOrderSubscription;
  late StreamSubscription<List<VerifiedOrderDetailOutletModel>>
      verifyOrderSubscription;
  late StreamSubscription<List<AssignedOrderDetailOutletModel>>
      assignedOrderSubscription;

  final RxList<String> _listOfIds = <String>[].obs;
  List<String> get listOfIds => _listOfIds;
  set listOfIds(List<String> lst) => _listOfIds.assignAll(lst);

  final orderList = [
    OrderEnum.preparing,
    OrderEnum.approved,
    OrderEnum.assigned,
    OrderEnum.completed,
    OrderEnum.cancel
  ];

  @override
  void onInit() {
    super.onInit();
    fetchdata();
    // fetchVerifiedOrderData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    newOrderSubscription.cancel();
    verifyOrderSubscription.cancel();
    newOrder.clear();
    newOrder.close();
    super.onClose();
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

  void fetchVerifiedOrderData() {
    // newOrder.bindStream(
    verifyOrderSubscription = outletRepo.apiService
        .fetchNewOrderStream<VerifiedOrderDetailOutletModel>(
            endpoint: '/api/VarifyOrder/ViewVerifiedOrderList',
            fromJson: (json) => VerifiedOrderDetailOutletModel.fromJson(json),
            query: {
          "UserId": sharedPreferenceService.getString(userUId)
        }).listen((data) {
      verifiedOrder.assignAll(data);
    });
  }

  void fetchAssignedOrderData() {
    // newOrder.bindStream(/api/VViewAssignOrderlistStatus/ViewOrderListByUser
    assignedOrderSubscription = outletRepo.apiService
        .fetchNewOrderStream<AssignedOrderDetailOutletModel>(
            endpoint: '/api/ViewAssignOrderlistStatus/ViewOrderListByUser',
            fromJson: (json) => AssignedOrderDetailOutletModel.fromJson(json),
            query: {
          "UserId": sharedPreferenceService.getString(userUId)
        }).listen((data) {
      assignedOrder.assignAll(data);
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
}
