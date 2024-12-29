import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/data/repos/outlet_repo.dart';
import 'package:mak_life_dairy_fresh/app/utils/app_enums/order_enum.dart';

class AdminDashboardController extends GetxController {
  //

  final OutletRepo outletRepo;
  AdminDashboardController({required this.outletRepo});

  final Rx<OrderEnum> _orderStatus = OrderEnum.preparing.obs;
  OrderEnum get orderStatus => _orderStatus.value;
  set orderStatus(OrderEnum lst) => _orderStatus.value = lst;

  final orderList = [
    OrderEnum.preparing,
    OrderEnum.approved,
    OrderEnum.assigned,
    OrderEnum.completed,
    OrderEnum.cancel
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
  }
}
