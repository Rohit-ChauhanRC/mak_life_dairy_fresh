import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/constants/constants.dart';
import 'package:mak_life_dairy_fresh/app/data/models/new_order_details_outlet.dart';
import 'package:mak_life_dairy_fresh/app/data/repos/outlet_repo.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';
import 'package:mak_life_dairy_fresh/app/utils/alert_popup_utils.dart';
import 'package:mak_life_dairy_fresh/app/utils/utils.dart';

class OutletOrderController extends GetxController {
  //

  final OutletRepo outletRepo;
  OutletOrderController({required this.outletRepo});

  final sharedPreferenceService = Get.find<SharedPreferenceService>();

  final RxString _id = "".obs;
  String get id => _id.value;
  set id(String str) => _id.value = str;

  final RxList<NewOrderDetailOutletModel> _newOrderDetail =
      <NewOrderDetailOutletModel>[].obs;
  List<NewOrderDetailOutletModel> get newOrderDetail => _newOrderDetail;
  set newOrderDetail(List<NewOrderDetailOutletModel> order) =>
      _newOrderDetail.assignAll(order);

  final RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;
  set totalAmount(double d) => _totalAmount.value = d;

  final RxList<String> _listOfIds = <String>[].obs;
  List<String> get listOfIds => _listOfIds;
  set listOfIds(List<String> lst) => _listOfIds.assignAll(lst);

  final RxList<String> _productListOfIds = <String>[].obs;
  List<String> get productListOfIds => _productListOfIds;
  set productListOfIds(List<String> lst) => _productListOfIds.assignAll(lst);

  @override
  void onInit() {
    id = Get.arguments;
    getSingleOrder();

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleCheckbox(int index, bool value) {
    newOrderDetail[index].isChecked.value = value;
    if (listOfIds.contains(newOrderDetail[index].productCode)) {
      listOfIds.remove(newOrderDetail[index].productCode);
      totalAmount -= double.parse(newOrderDetail[index].payAmount.toString());
    } else {
      listOfIds.add(newOrderDetail[index].productCode.toString());
      totalAmount += double.parse(newOrderDetail[index].payAmount.toString());
    }
    // update();
  }

  void getOrderDetails() async {
    try {
      newOrderDetail = (await outletRepo.getNewOrderDetails(id))!;
      print(newOrderDetail);
    } catch (e) {
      print(e);
    }
  }

  void getSingleOrder() async {
    final response = await outletRepo.getSingleOrder(id);
    if (response != null && response.statusCode == 200) {
      newOrderDetail = List<NewOrderDetailOutletModel>.from(
        response.data.map((x) => NewOrderDetailOutletModel.fromJson(x)),
      );

      // for (var data in newOrderDetail) {
      //   totalAmount += double.parse(data.payAmount!);
      // }
    }
  }

  Future<void> rejectOrder() async {
    for (var e in listOfIds) {
      debugPrint("Pulkit: $e");
    }
  }

  Future<void> verifyOrder() async {
    // if (listOfIds.isNotEmpty) {
    //   List<NewOrderDetailOutletModel> b = [];

    //   b.assignAll(newOrderDetail
    //       .where((item) => !listOfIds.contains(item.productCode))
    //       .toList());

    //   for (var e in b) {
    //     debugPrint("pulkit: ${e.productCode} ${e.product}");
    //     productListOfIds.add(e.productCode!);
    //   }
    // }

    try {
      final response = await outletRepo.verifyOrder(
        orderId: newOrderDetail.first.orderId.toString(),
        userId: sharedPreferenceService.getString(userUId)!,
        productIds: listOfIds,
      );
      final a = response?.data.toString();

      if (response != null &&
          response.statusCode == 200 &&
          a == "Orders processed successfully!") {
        Utils.showSnackBar(content: a!, context: Get.context!);

        Get.back();
      } else {
        // Utils.showDialog(json.decode(response?.data));
        showAlertMessage(response!.data.toString());
      }
    } catch (e) {
      showAlertMessage(e.toString());
    }
  }

  Future<void> orderRejectAll() async {
    try {
      final response = await outletRepo.orderRejectAll(
          orderId: newOrderDetail.first.orderId.toString(),
          userId: sharedPreferenceService.getString(userUId)!);
      final a = response?.data.toString();

      if (response != null &&
          response.statusCode == 200 &&
          a == "Rejected All") {
        Get.back();
      } else {
        // Utils.showDialog(json.decode(response?.data));
        showAlertMessage(response!.data.toString());
      }
    } catch (e) {
      showAlertMessage(e.toString());
    }
  }
}
