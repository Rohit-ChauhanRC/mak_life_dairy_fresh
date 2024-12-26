import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/routes/app_pages.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green.withOpacity(0.7),
      elevation: 10,
      // width: Get.width / 3,
      child: ListView(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.green,
                // color: Colors.white,
                backgroundImage: Image.asset("assets/logo.png").image,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
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
              ListTile(
                title: const Text(
                  "Add Delivery Boy",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                leading: const Icon(
                  Icons.delivery_dining_sharp,
                  color: Colors.white,
                  size: 40,
                ),
                onTap: () {
                  Get.toNamed(Routes.OUTLIE_ADD_DELIVERY_BOY);
                },
              ),
            ],
          ),
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
    );
  }
}
