
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mak_life_delivery/app/routes/app_pages.dart';

import '../../../data/repos/auth_repo.dart';
import '../../../utils/alert_popup_utils.dart';

class VerifyPhoneNumberController extends GetxController {
  final AuthRepository authRepository;

  VerifyPhoneNumberController({required this.authRepository});
  GlobalKey<FormState>? loginFormKey = GlobalKey<FormState>();

  final RxString _mobileNumber = '9876543210'.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String mobileNumber) => _mobileNumber.value = mobileNumber;

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxInt _current = 0.obs;
  int get current => _current.value;
  set current(int i) => _current.value = i;

  final CarouselSliderController carouselSliderController =
      CarouselSliderController();

  final List<String> imageUrls = [
    "assets/onb1.png",
    "assets/onb2.png",
    "assets/onb3.png",
    "assets/onb4.png"
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _mobileNumber.close();
  }

  void sendPhoneNumber() async {
    String phoneNumber = mobileNumber.trim();
  }

  Future login() async {
    if (!loginFormKey!.currentState!.validate()) {
      return null;
    }
    if (mobileNumber.trim() == "9876543210") {
      Get.toNamed(Routes.OTP, arguments: "9876543210");
    } else if (mobileNumber.trim() == "1234567890") {
      Get.toNamed(Routes.OTP, arguments: "1234567890");
    } else if (mobileNumber.trim() == "9123456789") {
      Get.toNamed(Routes.OTP, arguments: "9123456789");
    } else {
      await loginApiCall(mobileNumber.trim(), false);
    }
    // await loginCred(mobileNumber.trim(), false);
  }

  // loginCred(String? resendOtpMobNum, bool isFromResend) async {
  //   String? mobileNum = resendOtpMobNum ?? mobileNumber;
  //   circularProgress = false;
  //   try {
  //     var res = await http.post(Uri.parse("$baseUrl/api/Users"), body: {
  //       "MobileNo": mobileNum,
  //     });
  //     final a = jsonDecode(res.body);
  //
  //     if (res.statusCode == 200 && a == "OTP Sent !") {
  //       Get.toNamed(Routes.OTP, arguments: mobileNum);
  //     } else {
  //       //
  //       Utils.showDialog(json.decode(res.body));
  //     }
  //     circularProgress = true;
  //   } catch (e) {
  //     circularProgress = true;
  //     print("API error:-----> $e");
  //     Utils.showDialog(e.toString());
  //   }
  // }

  Future<void> loginApiCall(String? resendOtpMobNum, bool isFromResend) async {
    try {
      String? mobileNum = resendOtpMobNum ?? mobileNumber;
      circularProgress = false;
      final response = await authRepository.sendOTP(mobileNum);
      final a = response?.data.toString();
      if (response != null && response.statusCode == 200 && a == "OTP Sent !") {
        Get.toNamed(Routes.OTP, arguments: mobileNum);
      } else {
        // Utils.showDialog(json.decode(response?.data));
        showAlertMessage(response!.data.toString());
      }
    } finally {
      circularProgress = true;
    }
  }
}
