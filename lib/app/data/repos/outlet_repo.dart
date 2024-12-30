import 'package:mak_life_dairy_fresh/app/data/models/new_order_details_outlet.dart';
import 'package:mak_life_dairy_fresh/app/data/models/new_order_outlet_model.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';
import 'package:mak_life_dairy_fresh/app/utils/alert_popup_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      print('Error in sendOtpAPI: $e');
      showAlertMessage("Error in sendOTPAPI: $e");
      return null;
    }
  }

  Future<Response?> getSingleOrder(String orderId) async {
    try {
      final param = {'OrderId': orderId};
      return await apiService.get('/api/OrderDetail', query: param);
    } catch (e) {
      print('Error in verifyOTPAPI: $e');
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
      print('Error in verifyOTPAPI: $e');
      // showAlertMessage("Error in verifyOTPAPI: $e");
      return null;
    }
  }

  Future<Response?> verifyOrder({
    required String orderId,
    required String userId,
  }) async {
    try {
      final param = {
        "OrderId": orderId,
        "UserId": userId,
      };
      return await apiService.post('/api/VarifyOrder', data: param);
    } catch (e) {
      print('Error in verifyOTPAPI: $e');
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
      print('Error in verifyOTPAPI: $e');
      // showAlertMessage("Error in verifyOTPAPI: $e");
      return null;
    }
  }
}
