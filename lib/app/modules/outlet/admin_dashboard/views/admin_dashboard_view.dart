import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/routes/app_pages.dart';
import 'package:mak_life_dairy_fresh/app/utils/app_enums/order_enum.dart';
import 'package:mak_life_dairy_fresh/app/widgets/app_drawer.dart';

import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Container(
              height: 50,
              margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              width: Get.width,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.orderList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) {
                    final order = controller.orderList[i];
                    return InkWell(
                        onTap: () {
                          controller.orderStatus = order;
                        },
                        child: Obx(
                          () => Card(
                            margin: const EdgeInsets.only(
                              left: 30,
                              bottom: 5,
                            ),
                            color: controller.orderStatus == order
                                ? Colors.green
                                : Colors.grey,
                            elevation: 10,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                child: Text(
                                  order == OrderEnum.preparing
                                      ? "New Orders"
                                      : order == OrderEnum.pickedUp
                                          ? "Accepted Orders"
                                          : "Rejected Orders",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
                  }),
            ),
            Container(
              height: Get.height * .75,
              width: Get.width,
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
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
                              onPressed: () {
                                Get.toNamed(Routes.OUTLET_ORDER);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
