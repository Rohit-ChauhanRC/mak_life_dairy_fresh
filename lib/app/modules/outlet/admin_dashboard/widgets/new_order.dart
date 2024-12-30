import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/modules/outlet/admin_dashboard/controllers/admin_dashboard_controller.dart';
import 'package:mak_life_dairy_fresh/app/routes/app_pages.dart';

class NewOrder extends StatelessWidget {
  const NewOrder({super.key, required this.adminDashboardController});

  final AdminDashboardController adminDashboardController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .75,
      width: Get.width,
      padding: const EdgeInsets.all(10),
      child: Obx(() => adminDashboardController.newOrder.isNotEmpty
          ? ListView.builder(
              itemCount: adminDashboardController.newOrder.length,
              shrinkWrap: true,
              itemBuilder: (ctx, i) {
                return Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Order Id: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "${adminDashboardController.newOrder[i]!.orderId}",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Total Amount: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "₹${adminDashboardController.newOrder[i]!.paymentAmount}/-",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Customer Name: ",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "${adminDashboardController.newOrder[i]!.name}",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Date & Time: ",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "${adminDashboardController.newOrder[i]!.orderDate}",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: const Text(
                              "View",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.OUTLET_ORDER,
                                  arguments: adminDashboardController
                                      .newOrder[i]!.orderId!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
          : const SizedBox()),
    );
  }
}
