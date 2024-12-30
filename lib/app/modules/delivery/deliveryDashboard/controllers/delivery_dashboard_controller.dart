import 'dart:convert';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/constants/constants.dart';
import 'package:mak_life_dairy_fresh/app/data/models/get_assigned_order_model.dart';
import 'package:mak_life_dairy_fresh/app/data/repos/delivery_order_repo.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';

import '../../../../utils/alert_popup_utils.dart';

class DeliveryDashboardController extends GetxController {
  final DeliveryOrderRepository deliveryOrderRepository;

  DeliveryDashboardController({required this.deliveryOrderRepository});

  final sharedPresenceServices = Get.find<SharedPreferenceService>();

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxInt _totalOpenOrder = 0.obs;
  int get totalOpenOrder => _totalOpenOrder.value;
  set totalOpenOrder(int n) => _totalOpenOrder.value = n;

  final RxList<GetAssignedOrderModel> _getAllOrderList = <GetAssignedOrderModel>[].obs;
  List<GetAssignedOrderModel> get getAllOrderList => _getAllOrderList;
  set getAllOrderList(List<GetAssignedOrderModel> allOrderList) => _getAllOrderList.assignAll(allOrderList);

  final RxList<GetAssignedOrderModel> _getOpenOrders = <GetAssignedOrderModel>[].obs;
  List<GetAssignedOrderModel> get getOpenOrders => _getOpenOrders;
  set getOpenOrders(List<GetAssignedOrderModel> allOrderList) => _getOpenOrders.assignAll(allOrderList);

  final RxList<GetAssignedOrderModel> _getCompletedOrder = <GetAssignedOrderModel>[].obs;
  List<GetAssignedOrderModel> get getCompletedOrder => _getCompletedOrder;
  set getCompletedOrder(List<GetAssignedOrderModel> allOrderList) => _getCompletedOrder.assignAll(allOrderList);


  @override
  void onInit() {
    print("DeliveryBoyId:--------------> ${deliveryOrderRepository.getDeliveryBoyId()}");
    super.onInit();
    getAssignedOrderAPI();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAssignedOrderAPI() async{
    try{
      circularProgress = false;
      final response = await deliveryOrderRepository.getAssignOrder();
      if(response != null && response.statusCode == 200){
        getAllOrderList = List<GetAssignedOrderModel>.from(
          response.data.map((x) => GetAssignedOrderModel.fromJson(x)),
        );
        getOpenOrders = getAllOrderList.where((e) => e.status != "DELIVERED").toList();
        totalOpenOrder = getOpenOrders.length;
        getCompletedOrder = getAllOrderList.where((e) => e.status == "DELIVERED").toList();
      }else {
        showAlertMessage(json.decode(response?.data));
      }
    }finally{
      circularProgress = true;
    }
  }

  Future<void> updateOrderStatusAPI(String orderId, String statusCode) async{
    try{
      circularProgress = false;
      final response = await deliveryOrderRepository.updateOrderStatus(orderId, statusCode);
      if(response != null && response.statusCode == 200){

      }else {
        showAlertMessage(json.decode(response?.data));
      }
    }finally{
      circularProgress = true;
    }
  }

}
