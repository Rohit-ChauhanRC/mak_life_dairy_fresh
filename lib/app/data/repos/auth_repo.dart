import 'package:mak_life_dairy_fresh_delivery/app/data/services/shared_preference_service.dart';
import 'package:mak_life_dairy_fresh_delivery/app/utils/alert_popup_utils.dart';

import '../services/api_service.dart';
import 'package:dio/dio.dart';


class AuthRepository{
  final SharedPreferenceService sharedPreferences;
  final ApiService apiService;

  AuthRepository({required this.apiService, required this.sharedPreferences});

  Future<Response?> sendOTP(String mobileNumber) async{
    try{
      final param = {
        'MobileNo': mobileNumber
      };
      return await apiService.post('/api/Users', data: param);
    } catch(e){
      print('Error in sendOtpAPI: $e');
      showAlertMessage("Error in sendOTPAPI: $e");
      return null;
    }
  }

  Future<Response?> verifyOTP(String mobileNumber, String otp) async{
    try{
      final param = {
        "MobileNo": mobileNumber,
        "OTP": otp,
      };
      return await apiService.post('/api/Validation', data: param);
    } catch(e){
      print('Error in verifyOTPAPI: $e');
      showAlertMessage("Error in verifyOTPAPI: $e");
      return null;
    }
  }
}