import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/constants/constants.dart';
import 'package:mak_life_dairy_fresh/app/data/models/new_order_outlet_model.dart';
import 'package:mak_life_dairy_fresh/app/data/repos/outlet_repo.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';
import 'package:mak_life_dairy_fresh/app/utils/app_enums/order_enum.dart';

class AdminDashboardController extends GetxController {
  //

  final OutletRepo outletRepo;
  AdminDashboardController({required this.outletRepo});

  final sharedPreferenceService = Get.find<SharedPreferenceService>();

  final Rx<OrderEnum> _orderStatus = OrderEnum.preparing.obs;
  OrderEnum get orderStatus => _orderStatus.value;
  set orderStatus(OrderEnum lst) => _orderStatus.value = lst;

  final RxList<NewOrderOutletModel?> newOrder = <NewOrderOutletModel?>[].obs;

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
    fetchdata();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    newOrder.close();
  }

  void fetchdata() {
    newOrder.bindStream(
      outletRepo.apiService.fetchNewOrderStream<NewOrderOutletModel>(
          endpoint: '/api/ViewOrderList',
          fromJson: (json) => NewOrderOutletModel.fromJson(json),
          query: {"OutletId": sharedPreferenceService.getString(outletId)}),
    );
    print(newOrder);
  }
}
