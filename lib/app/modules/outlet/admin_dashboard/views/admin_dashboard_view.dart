import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/constants/colors.dart';
import 'package:mak_life_dairy_fresh/app/modules/outlet/admin_dashboard/widgets/approved_order.dart';
import 'package:mak_life_dairy_fresh/app/modules/outlet/admin_dashboard/widgets/assigned_order.dart';
import 'package:mak_life_dairy_fresh/app/modules/outlet/admin_dashboard/widgets/cancel_order.dart';
import 'package:mak_life_dairy_fresh/app/modules/outlet/admin_dashboard/widgets/delivered_order.dart';
import 'package:mak_life_dairy_fresh/app/modules/outlet/admin_dashboard/widgets/new_order.dart';
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
              margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
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
                          if (order == OrderEnum.approved) {
                            controller.fetchVerifiedOrderData();
                          } else if (order == OrderEnum.assigned) {
                            controller.fetchAssignedOrderData();
                          } else if (order == OrderEnum.completed) {
                            // controller.fetchVerifiedOrderData();
                          } else if (order == OrderEnum.cancel) {
                            // controller.fetchVerifiedOrderData();
                          }
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
                                      : order == OrderEnum.approved
                                          ? "Approved Orders"
                                          : order == OrderEnum.assigned
                                              ? "Assigned Orders"
                                              : order == OrderEnum.completed
                                                  ? "Order Delivered"
                                                  : "Canceled Orders",
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
            Obx(() => controller.orderStatus == OrderEnum.approved &&
                    controller.refreshVerifiedOrder.value == false
                ? InkWell(
                    onTap: () {
                      controller.fetchVerifiedOrderData();
                    },
                    child: const Icon(Icons.refresh),
                  )
                : const SizedBox()),
            Obx(() => controller.orderStatus == OrderEnum.preparing
                ? NewOrder(adminDashboardController: controller)
                : controller.orderStatus == OrderEnum.approved
                    ? SizedBox(
                        child: controller.refreshVerifiedOrder.value == false
                            ? ApprovedOrder(
                                adminDashboardController: controller)
                            : const Center(
                                child: SizedBox(
                                    child: CircularProgressIndicator()),
                              ))
                    : controller.orderStatus == OrderEnum.assigned
                        ? AssignedOrder(adminDashboardController: controller)
                        : controller.orderStatus == OrderEnum.completed
                            ? DeliveredOrder(
                                adminDashboardController: controller)
                            : CancelOrder(
                                adminDashboardController: controller)),
          ],
        ),
      ),
    );
  }
}
