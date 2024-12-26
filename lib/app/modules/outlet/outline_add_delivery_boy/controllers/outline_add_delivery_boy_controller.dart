import 'dart:io';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/utils/utils.dart';
import 'package:flutter/material.dart';

class OutlineAddDeliveryBoyController extends GetxController {
  //
  final Rx<File?> _image = Rx<File?>(null);
  File? get image => _image.value;
  set image(File? img) => _image.value = img;

  final RxString _profileName = ''.obs;
  String get profileName => _profileName.value;
  set profileName(String pr) => _profileName.value = pr;

  final RxString _email = ''.obs;
  String get email => _email.value;
  set email(String email) => _email.value = email;

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String no) => _mobileNumber.value = no;

  final RxString _licenseNo = ''.obs;
  String get licenseNo => _licenseNo.value;
  set licenseNo(String lo) => _licenseNo.value = lo;

  final RxString _vehicleNo = ''.obs;
  String get vehicleNo => _vehicleNo.value;
  set vehicleNo(String vo) => _vehicleNo.value = vo;

  final RxString _bankAc = ''.obs;
  String get bankAc => _bankAc.value;
  set bankAc(String vo) => _bankAc.value = vo;

  final RxString _ifscCode = ''.obs;
  String get ifscCode => _ifscCode.value;
  set ifscCode(String ifsc) => _ifscCode.value = ifsc;

  final RxString _address = ''.obs;
  String get address => _address.value;
  set address(String ifsc) => _address.value = ifsc;

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final TextEditingController profileNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  GlobalKey<FormState>? createProfileKey = GlobalKey<FormState>();

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
  }

  void selectImage() async {
    Utils.showImagePicker(onGetImage: (img) {
      if (img != null) {
        image = img;
      }
    });
  }

  void createProfile() async {
    String profileNam = profileNameController.text.trim();
    String emailId = emailController.text.trim();
    if (profileNam.isNotEmpty && emailId.isNotEmpty) {
      await validateProfileData();
    } else {
      Utils.showSnackBar(
          context: Get.context!, content: 'Fill out all the fields');
    }
  }

  Future validateProfileData() async {
    if (!createProfileKey!.currentState!.validate()) {
      return null;
    }
    // Get.toNamed(Routes.HOME);
    // storeUserData();
  }
}
