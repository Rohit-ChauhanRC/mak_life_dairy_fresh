import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mak_life_dairy_fresh/app/data/models/otp_model.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';
import 'package:mak_life_dairy_fresh/app/constants/constants.dart';
import 'package:mak_life_dairy_fresh/app/routes/app_pages.dart';
import 'package:mak_life_dairy_fresh/app/modules/verifyPhoneNumber/controllers/verify_phone_number_controller.dart';
import 'package:mak_life_dairy_fresh/app/utils/utils.dart';
import 'package:mak_life_dairy_fresh/app/constants/api_constant.dart';

class OtpController extends GetxController {
  final sharedPreferenceService =
      Get.put<SharedPreferenceService>(SharedPreferenceService());
  final verifyPhoneNumberController = Get.find<VerifyPhoneNumberController>();
  GlobalKey<FormState>? otpFormKey = GlobalKey<FormState>();

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String mobileNumber) => _mobileNumber.value = mobileNumber;

  final RxString _otp = ''.obs;
  String get otp => _otp.value;
  set otp(String op) => _otp.value = op;

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  RxInt timerValue = 60.obs;
  RxBool isResendEnabled = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    mobileNumber = Get.arguments;
    startTimer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    timerValue.value = 60;
    isResendEnabled.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue.value > 0) {
        timerValue.value--;
      } else {
        timer.cancel();
        isResendEnabled.value = true;
      }
    });
  }

  void resendOtp() {
    if (isResendEnabled.value) {
      startTimer();
      verifyPhoneNumberController.loginCred(mobileNumber, true);
    }
  }

  Future login() async {
    if (!otpFormKey!.currentState!.validate()) {
      return null;
    }
    await verifyOTPLoginCred();
  }

  verifyOTPLoginCred() async {
    circularProgress = false;
    try {
      var res = await http.post(Uri.parse("$baseUrl/api/Validation"), body: {
        "MobileNo": mobileNumber,
        "OTP": otp,
      });
      // List<OtpModel> jsonList = jsonDecode(res.body);

      // List<OtpModel> userLogs =
      //     jsonList.map((json) => OtpModel.fromJson(json)).toList();

      List<OtpModel> userLogs = otpModelFromJson(res.body);

      if (userLogs.first.userId.toString().isNotEmpty) {
        saveIsNumVerified(true, userLogs.first.userId.toString(),
            userLogs.first.logType.toString());
        if (userLogs.first.logType == "C") {
          Get.offAllNamed(Routes.HOME,
              arguments: userLogs.first.userId.toString());
        } else if (userLogs.first.logType == "A") {
          Get.offAllNamed(Routes.ADMIN_DASHBOARD,
              arguments: userLogs.first.userId.toString());
        } else if (userLogs.first.logType == "D") {
          Get.offAllNamed(Routes.DELIVERY_DASHBOARD,
              arguments: userLogs.first.userId.toString());
        }
      } else {
        // Utils.showDialog(json.decode(res.body));
        Utils.showDialog(json.decode(res.body));
      }
      circularProgress = true;
    } catch (e) {
      circularProgress = true;
      Utils.showDialog(e.toString());

      // showSnackBar(context: Get.context!, content: e.toString());
    }
  }

  void saveIsNumVerified(
    bool isNumVerified,
    String uid,
    String logtype,
  ) {
    // sharedPreferenceService.setBool(isNumVerify, isNumVerified);
    sharedPreferenceService.setString(userUId, uid);
    sharedPreferenceService.setString(logtype, logtype);
  }
}
