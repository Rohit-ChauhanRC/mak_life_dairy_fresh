import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/routes/app_pages.dart';
import 'package:mak_life_dairy_fresh/app/widgets/app_drawer.dart';

import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: Image.asset("assets/logo.png").image,
              radius: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            const Text("Admin"),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.OUTLET_NOTIFICATIONS);
            },
            child: const Icon(
              Icons.notifications_active,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, i) {
                return Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: "Order Id: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: "#121223213",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text("Pending"),
                        TextButton(
                          child: const Text("View"),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
