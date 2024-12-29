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

  Stream<dynamic>? getOutletOrderList() {
    try {
      return apiService.fetchStream<List<NewOrderOutletModel>>(
          '/api/ViewOrderList',
          query: {"OutletId": 871});
    } catch (e) {
      print('Error in sendOtpAPI: $e');
      showAlertMessage("Error in sendOTPAPI: $e");
      return null;
    }
  }

  Future<Response?> sendOTP(String mobileNumber) async {
    try {
      final param = {'MobileNo': mobileNumber};
      return await apiService.post('/api/Users', data: param);
    } catch (e) {
      print('Error in sendOtpAPI: $e');
      showAlertMessage("Error in sendOTPAPI: $e");
      return null;
    }
  }
}
