import 'package:mak_life_dairy_fresh/app/constants/api_constant.dart';
import 'package:mak_life_dairy_fresh/app/data/models/new_order_details_outlet.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';

import '../services/api_service.dart';
import 'package:dio/dio.dart';

class OutletRepo {
  final SharedPreferenceService sharedPreferences;
  final ApiService apiService;

  OutletRepo({required this.apiService, required this.sharedPreferences});

  //

  Future<List<NewOrderDetailOutletModel>?> getNewOrderDetails(
      String orderId) async {
    try {
      final param = {'OrderId': orderId};
      return await apiService.fetchList<NewOrderDetailOutletModel>(
          endpoint: '/api/OrderDetail',
          query: param,
          fromJson: (json) => NewOrderDetailOutletModel.fromJson(json));
    } catch (e) {
      return null;
    }
  }

  Future<Response?> getSingleOrder(String orderId) async {
    try {
      final param = {'OrderId': orderId};
      return await apiService.get('/api/OrderDetail', query: param);
    } catch (e) {
      // showAlertMessage("Error in verifyOTPAPI: $e");
      return null;
    }
  }

  Future<Response?> rejectSingleOrder({
    required String orderId,
    required String userId,
    required String productId,
  }) async {
    try {
      final param = {
        "OrderId": orderId,
        "UserId": userId,
        "ProductId": productId
      };
      return await apiService.post('/api/OrderReject', data: param);
    } catch (e) {
      // showAlertMessage("Error in verifyOTPAPI: $e");
      return null;
    }
  }

  Future<Response?> verifyOrder({
    required String orderId,
    required String userId,
    required List<String> productIds,
  }) async {
    try {
      final param = {
        "OrderId": orderId,
        "UserId": userId,
        "ProductIds": productIds,
      };
      return await apiService.post(varifyOrder, data: param);
    } catch (e) {
      // showAlertMessage("Error in verifyOTPAPI: $e");
      return null;
    }
  }

  Future<Response?> orderRejectAll({
    required String orderId,
    required String userId,
  }) async {
    try {
      final param = {
        "OrderId": orderId,
        "UserId": userId,
      };
      return await apiService.post('/api/OrderRejectAll', data: param);
    } catch (e) {
      // showAlertMessage("Error in verifyOTPAPI: $e");
      return null;
    }
  }

  Future<Response?> verifyOrdersListForAssigning(String userId) async {
    try {
      final param = {
        "UserId": userId,
      };
      return await apiService.get(viewVerifiedOrder, query: param);
    } catch (e) {
      return null;
    }
  }

  Future<Response?> fetchDeliveryBoyList(String userId) async {
    try {
      final param = {
        "UserId": userId,
      };
      return await apiService.get(deliveryBoyList, query: param);
    } catch (e) {
      return null;
    }
  }

  Future<Response?> orderAssigningDeliveryBoy({
    required List<String> orderIds,
    required String userId,
    required String deliveryBoyId,
    required String outletId,
  }) async {
    try {
      final param = {
        "OrderIds": orderIds,
        "UserId": userId,
        "DeliveryBoyId": deliveryBoyId,
        "OutletId": outletId,
        "AssignOrdersIdTo": deliveryBoyId,
      };
      return await apiService.post(assignOrders, data: param);
    } catch (e) {
      // showAlertMessage("Error in verifyOTPAPI: $e");
      return null;
    }
  }
}
