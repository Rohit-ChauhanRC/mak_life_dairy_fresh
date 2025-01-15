import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mak_life_delivery/app/data/models/get_assigned_order_model.dart';
import 'package:mak_life_delivery/app/data/repos/delivery_order_repo.dart';
import 'package:mak_life_delivery/app/data/services/shared_preference_service.dart';

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

  late StreamSubscription<List<GetAssignedOrderModel>> getAllOrderSubscription;

  final RxList<GetAssignedOrderModel> _getAllOrderList = <GetAssignedOrderModel>[].obs;
  List<GetAssignedOrderModel> get getAllOrderList => _getAllOrderList;
  set getAllOrderList(List<GetAssignedOrderModel> allOrderList) => _getAllOrderList.assignAll(allOrderList);

  final RxList<GetAssignedOrderModel> _getOpenOrders = <GetAssignedOrderModel>[].obs;
  List<GetAssignedOrderModel> get getOpenOrders => _getOpenOrders;
  set getOpenOrders(List<GetAssignedOrderModel> allOrderList) => _getOpenOrders.assignAll(allOrderList);

  final RxList<GetAssignedOrderModel> _getCompletedOrder = <GetAssignedOrderModel>[].obs;
  List<GetAssignedOrderModel> get getCompletedOrder => _getCompletedOrder;
  set getCompletedOrder(List<GetAssignedOrderModel> allOrderList) => _getCompletedOrder.assignAll(allOrderList);

  final Rx<LatLng> _currentPosition = LatLng(0.0, 0.0).obs;
  LatLng get currentPosition => _currentPosition.value;
  set currentPosition(LatLng value) => _currentPosition.value = value;

  @override
  void onInit() {
    print("DeliveryBoyId:--------------> ${deliveryOrderRepository.getDeliveryBoyId()}");
    super.onInit();
    fetchAssignedOrderAPI();
    getCurrentLocation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    getAllOrderSubscription.cancel();
  }

  void fetchAssignedOrderAPI() {
    getAllOrderSubscription = deliveryOrderRepository.apiService
        .fetchNewOrderStream<GetAssignedOrderModel>(
    endpoint: '/api/AssignOrdersToDeliveryBoy',
    fromJson: (json) => GetAssignedOrderModel.fromJson(json),
    query: {
      "UserId": deliveryOrderRepository.getDeliveryBoyId()
      // "UserId": 1005
    }).listen((data) {
    getAllOrderList.assignAll(data);
    getOpenOrders = getAllOrderList.where((e) => e.status != "DELIVERED").toList();
    totalOpenOrder = getOpenOrders.length;
    sortOpenOrdersByDistance();
    print("Sorted open orders by distance: ${getOpenOrders.map((e) => e.orderId).toList()}");
    getCompletedOrder = getAllOrderList.where((e) => e.status == "DELIVERED").toList();
    });
  }

  /// Sorts the open orders by the shortest distance from the delivery person's current position.
  void sortOpenOrdersByDistance() {
    print("Sorting open orders by distance...");
    getOpenOrders.sort((a, b) {
      double distanceA = calculateDistance(
        currentPosition.latitude,
        currentPosition.longitude,
        a.shippingLatt ?? 0.0,
        a.shippingLong ?? 0.0,
      );
      double distanceB = calculateDistance(
        currentPosition.latitude,
        currentPosition.longitude,
        b.shippingLatt ?? 0.0,
        b.shippingLong ?? 0.0,
      );
      return distanceA.compareTo(distanceB);
    });
    print("Sorted open orders: ${getOpenOrders.map((e) => e.orderId).toList()}");
  }

  /// Calculates the distance between two geographic points using the Haversine formula.
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // Radius of Earth in kilometers
    double dLat = (lat2 - lat1) * (pi / 180);
    double dLon = (lon2 - lon1) * (pi / 180);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * (pi / 180)) * cos(lat2 * (pi / 180)) *
            sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in kilometers
  }

  /// Fetches the current location of the delivery person.
  Future<void> getCurrentLocation() async {
    Location locationService = Location();
    bool serviceEnabled = await locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationService.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    LocationData locationData = await locationService.getLocation();
    currentPosition = LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
    print("Current location lat & long: $currentPosition");
    // Re-sort open orders whenever location is updated
    sortOpenOrdersByDistance();
  }

  //Onetime Future call API
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


}
