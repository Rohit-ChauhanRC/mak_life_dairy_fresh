import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/constants/constants.dart';
import 'package:mak_life_dairy_fresh/app/data/models/new_order_details_outlet.dart';
import 'package:mak_life_dairy_fresh/app/data/repos/outlet_repo.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';
import 'package:mak_life_dairy_fresh/app/utils/alert_popup_utils.dart';

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
      totalAmount += double.parse(newOrderDetail[index].payAmount.toString());
    } else {
      listOfIds.add(newOrderDetail[index].productCode.toString());
      totalAmount -= double.parse(newOrderDetail[index].payAmount.toString());
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

      for (var data in newOrderDetail) {
        totalAmount += double.parse(data.payAmount!);
      }
    }
  }

  Future<void> rejectOrder() async {
    try {
      if (listOfIds.isNotEmpty) {
        for (var i = 0; i < listOfIds.length; i++) {
          await outletRepo.rejectSingleOrder(
            orderId: newOrderDetail.first.orderId.toString(),
            productId: listOfIds[i],
            userId: sharedPreferenceService.getString(userUId)!,
          );
        }
      }
    } catch (e) {
      showAlertMessage(e.toString());
    }
  }

  Future<void> verifyOrder() async {
    try {
      final response = await outletRepo.verifyOrder(
          orderId: newOrderDetail.first.orderId.toString(),
          userId: sharedPreferenceService.getString(userUId)!);
      final a = response?.data.toString();

      if (response != null &&
          response.statusCode == 200 &&
          a == "Order verified successfully !") {
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
