import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mak_life_delivery/app/data/models/get_assigned_order_model.dart';
import 'package:mak_life_delivery/app/data/repos/delivery_order_repo.dart';
import 'package:mak_life_delivery/app/data/services/shared_preference_service.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/api_constant.dart';
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
    final newOpenOrders = getAllOrderList.where((e) => e.status != "DELIVERED").toList();
    final newCompletedOrders = getAllOrderList.where((e) => e.status == "DELIVERED").toList();

    // getOpenOrders.assignAll(newOpenOrders);
    totalOpenOrder = newOpenOrders.length;
    sortOpenOrdersByDistance(newOpenOrders);

    getCompletedOrder.assignAll(newCompletedOrders);
    });
  }

  /// Sorts the open orders by the shortest distance from the delivery person's current position.
  void sortOpenOrdersByDistance(List<GetAssignedOrderModel> newOpenOrders) async {
    if (newOpenOrders.isEmpty || currentPosition.latitude == 0.0 || currentPosition.longitude == 0.0) {
      print("No open orders or current location not set.");
      return;
    }
    print("Fetching distances from Google Distance Matrix API...");

    try {
      // Build the origin and destinations strings
      String origins = "${currentPosition.latitude},${currentPosition.longitude}";
      String destinations = newOpenOrders.map((e) => "${e.shippingLatt},${e.shippingLong}").join('|');

      // Distance Matrix API URL
      final String url =
          'https://maps.googleapis.com/maps/api/distancematrix/json?'
          'origins=$origins&destinations=$destinations&mode=driving&departure_time=now&key=$googleMapApiKey';

      // API Call
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          // Extract distances and map to open orders
          List<dynamic> rows = data['rows'][0]['elements'];
          for (int i = 0; i < rows.length; i++) {
            final distanceText = rows[i]['distance']['text']; // Human-readable distance
            final distanceValue = rows[i]['distance']['value']; // Distance in meters
            newOpenOrders[i].distance?.value = distanceValue / 1000;
            // getOpenOrders[i].distance?.value = double.parse(distanceText.split(' ')[0]); // Extract numeric value
            print("Order ID: ${newOpenOrders[i].orderId}, "
                "Distance: ${newOpenOrders[i].distance?.value.toStringAsFixed(2)} km");
          }

          // Sort orders based on distance
          newOpenOrders.sort((a, b) => (a.distance?.value ?? 0.0).compareTo(b.distance?.value ?? 0.0));
          getOpenOrders.assignAll(newOpenOrders);
          print("Open orders sorted by distance: ${getOpenOrders.map((e) => e.orderId).toList()}");
        } else {
          print("Error in Distance Matrix API response: ${data['error_message']}");
        }
      } else {
        print("Failed to fetch distances. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching distances: $e");
    }
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
