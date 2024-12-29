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

  // Stream<List<NewOrderOutletModel>?> fetchNewOrderStream({
  //   Map<String, dynamic>? query,
  //   Duration interval = const Duration(seconds: 5),
  // }) {
  //   return apiService.fetchStream<List<NewOrderOutletModel>>(
  //     "/api/ViewOrderList",
  //     query: query,
  //     interval: interval,
  //     converter: (data) {
  //       if (data is List) {
  //         return data
  //             .map((item) => NewOrderOutletModel.fromJson(item))
  //             .toList();
  //       }
  //       return [];
  //     },
  //   );
  // }

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
}
