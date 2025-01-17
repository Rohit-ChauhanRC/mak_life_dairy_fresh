import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';
import 'package:mak_life_dairy_fresh/app/modules/outlet/admin_dashboard/controllers/admin_dashboard_controller.dart';
import 'package:mak_life_dairy_fresh/app/routes/app_pages.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    super.key,
  });

  final sharedPreferenceService = Get.find<SharedPreferenceService>();

  final AdminDashboardController controller =
      Get.find<AdminDashboardController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green.withOpacity(0.7),
      elevation: 10,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.green,
                      foregroundImage: Image.asset(
                        "assets/outlet_logo.jpeg",
                        fit: BoxFit.contain,
                      ).image,
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.white),
                    const SizedBox(height: 20),
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.OUTLET_PROFILE);
                      },
                      title: const Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    // ListTile(
                    //   title: const Text(
                    //     "Add Delivery Boy",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 26,
                    //     ),
                    //   ),
                    //   leading: const Icon(
                    //     Icons.delivery_dining_sharp,
                    //     color: Colors.white,
                    //     size: 40,
                    //   ),
                    //   onTap: () {
                    //     Get.toNamed(Routes.OUTLIE_ADD_DELIVERY_BOY);
                    //   },
                    // ),
                    ListTile(
                      title: const Text(
                        "Notifications",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                      leading: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 40,
                      ),
                      onTap: () {
                        Get.toNamed(Routes.OUTLET_NOTIFICATIONS);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white),
          ListTile(
            title: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
              ),
            ),
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 40,
            ),
            onTap: () {
              sharedPreferenceService.clear();
              controller.assignedOrderSubscription.cancel();
              controller.newOrderSubscription.cancel();
              Get.offAllNamed(Routes.VERIFY_PHONE_NUMBER);
            },
          ),
        ],
      ),
    );
  }
}
