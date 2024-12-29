import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/data/repos/outlet_repo.dart';

import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>
        OutletRepo(apiService: Get.find(), sharedPreferences: Get.find()));
    Get.lazyPut<AdminDashboardController>(
      () => AdminDashboardController(outletRepo: Get.find()),
    );
  }
}
