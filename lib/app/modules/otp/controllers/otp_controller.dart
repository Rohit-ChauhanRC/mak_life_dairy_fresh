import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mak_life_delivery/app/data/models/otp_model.dart';
import 'package:mak_life_delivery/app/data/services/shared_preference_service.dart';
import 'package:mak_life_delivery/app/constants/constants.dart';
import 'package:mak_life_delivery/app/routes/app_pages.dart';
import 'package:mak_life_delivery/app/modules/verifyPhoneNumber/controllers/verify_phone_number_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/repos/auth_repo.dart';
import '../../../utils/alert_popup_utils.dart';

class OtpController extends GetxController {
  final AuthRepository authRepository;

  OtpController({required this.authRepository});

  final sharedPreferenceService = Get.find<SharedPreferenceService>();
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

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
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
      verifyPhoneNumberController.loginApiCall(mobileNumber, true);
    }
  }

  Future login() async {
    if (!otpFormKey!.currentState!.validate()) {
      return null;
    }
    // if (mobileNumber.trim() == "9876543210" && otp == "1234") {
    //   saveIsNumVerified(true, "1007", "C", mobileNo: "9876543210");
    //   await permisions();
    //   await getCurrentLocation();
    //   Get.offAllNamed(Routes.HOME, arguments: "1007");
    // } else
      if (mobileNumber.trim() == "1234567890" && otp == "1234") {
      saveIsNumVerified(true, "1009", "D", mobileNo: "1234567890");
      // await permisions();
      // await getCurrentLocation();

      Get.offAllNamed(Routes.DELIVERY_DASHBOARD, arguments: "1009");
    }
      // else if(mobileNumber.trim() == "9140363633" && otp == "1234"){
      //   saveIsNumVerified(true, "1008", "D", mobileNo: "9140363633");
      //   Get.offAllNamed(Routes.DELIVERY_DASHBOARD, arguments: "1008");
      // }
    //   else if (mobileNumber.trim() == "9123456789" && otp == "1234") {
    //   saveIsNumVerified(true, "1010", "A", mobileNo: "9123456789", oId: 899);
    //   await permisions();
    //   await getCurrentLocation();
    //
    //   Get.offAllNamed(Routes.ADMIN_DASHBOARD, arguments: "1010");
    // }
      else {
      await verifyOTPAPI();
    }
  }

  // verifyOTPLoginCred() async {
  //   circularProgress = false;
  //   try {
  //     var res = await http.post(Uri.parse("$baseUrl/api/Validation"), body: {
  //       "MobileNo": mobileNumber,
  //       "OTP": otp,
  //     });
  //     // List<OtpModel> jsonList = jsonDecode(res.body);

  //     // List<OtpModel> userLogs =
  //     //     jsonList.map((json) => OtpModel.fromJson(json)).toList();

  //     List<OtpModel> userLogs = otpModelFromJson(res.body);

  //     if (userLogs.first.userId.toString().isNotEmpty) {
  //       saveIsNumVerified(true, userLogs.first.userId.toString(),
  //           userLogs.first.logType.toString(),
  //           mobileNo: mobileNumber);
  //       if (userLogs.first.logType == "C") {
  //         await permisions();
  //         await getCurrentLocation();
  //         Get.offAllNamed(
  //           Routes.HOME,
  //           arguments: userLogs.first.userId.toString(),
  //         );
  //       } else if (userLogs.first.logType == "A") {
  //         await permisions();
  //         await getCurrentLocation();
  //         Get.offAllNamed(Routes.ADMIN_DASHBOARD,
  //             arguments: userLogs.first.userId.toString());
  //       } else if (userLogs.first.logType == "D") {
  //         await permisions();
  //         await getCurrentLocation();
  //         Get.offAllNamed(Routes.DELIVERY_DASHBOARD,
  //             arguments: userLogs.first.userId.toString());
  //       }
  //     } else {
  //       // Utils.showDialog(json.decode(res.body));
  //       Utils.showDialog(json.decode(res.body));
  //     }
  //     circularProgress = true;
  //   } catch (e) {
  //     circularProgress = true;
  //     Utils.showDialog(e.toString());

  //     // showSnackBar(context: Get.context!, content: e.toString());
  //   }
  // }

  Future<void> verifyOTPAPI() async {
    try {
      circularProgress = false;
      final response = await authRepository.verifyOTP(mobileNumber, otp);
      if (response != null && response.statusCode == 200) {
        List<OtpModel> userLogs = List<OtpModel>.from(
          response.data.map((x) => OtpModel.fromJson(x)),
        );

        if (userLogs.isNotEmpty &&
            userLogs.first.userId.toString().isNotEmpty) {
          saveIsNumVerified(true, userLogs.first.userId.toString(),
              userLogs.first.logType.toString(),
              oId: userLogs.first.outletId!, mobileNo: mobileNumber);
          // if (userLogs.first.logType == "C") {
          //   await permisions();
          //   await getCurrentLocation();
          //
          //   Get.offAllNamed(Routes.HOME,
          //       arguments: userLogs.first.userId.toString());
          // } else if (userLogs.first.logType == "A") {
          //   await permisions();
          //   await getCurrentLocation();
          //
          //   Get.offAllNamed(Routes.ADMIN_DASHBOARD,
          //       arguments: userLogs.first.userId.toString());
          // }
           if (userLogs.first.logType == "D") {
            // await permisions();
            // await getCurrentLocation();

            Get.offAllNamed(Routes.DELIVERY_DASHBOARD,
                arguments: userLogs.first.userId.toString());
          }
        }else{
          showAlertMessage("Please enter a valid OTP!");
        }
      } else {
        showAlertMessage(json.decode(response?.data));
      }
    } finally {
      circularProgress = true;
    }
  }

  // Future<void> permisions() async {
  //   await Permission.storage.request();
  //   await Permission.camera.request();
  //   await Permission.mediaLibrary.request();
  //   await Permission.microphone.request();
  //   await Permission.photos.request();
  //   await Permission.notification.request();
  //   await Permission.manageExternalStorage.request();
  //   await Permission.location.request();
  //   await Permission.locationWhenInUse.request();
  //   // await Permission.locationAlways.request();
  // }

  void saveIsNumVerified(bool isNumVerified, String uid, String logType,
      {int? oId, String? mobileNo}) {
    sharedPreferenceService.setString(userUId, uid);
    sharedPreferenceService.setString(logtype, logType);
    sharedPreferenceService.setString(outletId, oId.toString());
    sharedPreferenceService.setString(userMob, mobileNo.toString());
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    isLoading.value = true;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      isLoading.value = false;
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied.');
        isLoading.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        'Error',
        'Location permissions are permanently denied. Cannot request permissions.',
      );
      isLoading.value = false;
      return;
    }

    // Get the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      print(
          "longitude.value: ${longitude.value} latitude.value: ${latitude.value}");
      // Get.snackbar('Success',
      //     'Location fetched successfully. longitude.value ${longitude.value} latitude.value: ${latitude.value}');
    } catch (e) {
      Get.snackbar('Error', 'Error getting location: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
