import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/data/models/new_order_details_outlet.dart';
import 'package:mak_life_dairy_fresh/app/data/repos/outlet_repo.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';

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

  // final RxList<Map<String, dynamic>> _items = <Map<String, dynamic>>[].obs;

  // List<Map<String, dynamic>> get items => _items;
  // set(List<Map<String, dynamic>> lst) => _items.assignAll(lst);
  List<Map<String, dynamic>> items = List.generate(
    10,
    (index) => {'label': 'Item ${index + 1}', 'isChecked': false}.obs,
  ).obs;

  @override
  void onInit() {
    id = Get.arguments;
    getOrderDetails();

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
    items[index]['isChecked'] = value;
  }

  void getOrderDetails() async {
    try {
      newOrderDetail = (await outletRepo.getNewOrderDetails(id))!;
      print(newOrderDetail);
    } catch (e) {
      print(e);
    }
  }
}
