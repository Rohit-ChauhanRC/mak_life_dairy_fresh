import 'package:get/get.dart';

class OutletOrderController extends GetxController {
  //
  // final RxList<Map<String, dynamic>> _items = <Map<String, dynamic>>[].obs;

  // List<Map<String, dynamic>> get items => _items;
  // set(List<Map<String, dynamic>> lst) => _items.assignAll(lst);
  List<Map<String, dynamic>> items = List.generate(
    10,
    (index) => {'label': 'Item ${index + 1}', 'isChecked': false}.obs,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    // items.assignAll(List.generate(
    //   10,
    //   (index) => {
    //     'label': 'Item ${index + 1}',
    //     'isChecked': false,
    //   },
    // ));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleCheckbox(int index, bool value) {
    items[index]['isChecked'] = value;
  }
}
