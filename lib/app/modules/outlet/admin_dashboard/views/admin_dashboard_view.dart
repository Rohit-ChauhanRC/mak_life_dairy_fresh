import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      children: [
                        const Text("Order Id: 12232323423"),
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
