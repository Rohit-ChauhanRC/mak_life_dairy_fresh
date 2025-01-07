import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/data/models/verified_order_outlet.dart';
import 'package:mak_life_dairy_fresh/app/modules/outlet/admin_dashboard/controllers/admin_dashboard_controller.dart';
import 'package:mak_life_dairy_fresh/app/routes/app_pages.dart';
import 'package:mak_life_dairy_fresh/app/utils/app_enums/order_enum.dart';
import 'package:mak_life_dairy_fresh/app/utils/utils.dart';

class ApprovedOrder extends StatelessWidget {
  const ApprovedOrder({super.key, required this.adminDashboardController});

  final AdminDashboardController adminDashboardController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Get.height * .40,
            width: Get.width,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green)),
            child: Obx(() => adminDashboardController.verifiedOrder.isNotEmpty
                ? ListView.builder(
                    itemCount: adminDashboardController.verifiedOrder.reversed
                        .toList()
                        .length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) {
                      return Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Assign",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Obx(() => Checkbox(
                                          activeColor: Colors.green,
                                          value: adminDashboardController
                                              .verifiedOrder.reversed
                                              .toList()[i]!
                                              .isChecked
                                              .value,
                                          onChanged: (bool? value) {
                                            adminDashboardController
                                                .toggleCheckbox(i, value!);
                                          },
                                        )),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          text: adminDashboardController
                                              .verifiedOrder.reversed
                                              .toList()[i]!
                                              .orderId,
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
                                              "₹${adminDashboardController.verifiedOrder.reversed.toList()[i]!.paymentAmount}/-",
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
                                      text: adminDashboardController
                                          .verifiedOrder.reversed
                                          .toList()[i]!
                                          .name,
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
                                  text: "Customer Mobile No.: ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: adminDashboardController
                                          .verifiedOrder.reversed
                                          .toList()[i]!
                                          .mobileNo,
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
                                  text: "Order Date & Time: ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: adminDashboardController
                                          .verifiedOrder.reversed
                                          .toList()[i]!
                                          .orderDate,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "\t\t ${Utils.timeFormated(adminDashboardController.verifiedOrder.reversed.toList()[i]!.orderTime!)}",
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
                                  text: "Payment Status: ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: adminDashboardController
                                          .verifiedOrder.reversed
                                          .toList()[i]!
                                          .paymentStatus,
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
                                  text: "Order Status: ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: adminDashboardController
                                          .verifiedOrder.reversed
                                          .toList()[i]!
                                          .status,
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
                                        arguments: [
                                          adminDashboardController
                                              .verifiedOrder.reversed
                                              .toList()[i]!
                                              .orderId!,
                                          OrderEnum.approved
                                        ]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : const SizedBox()),
          ),
          Container(
            height: 120,
            margin: const EdgeInsets.all(10),
            width: Get.width,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green)),
            child: Obx(() => adminDashboardController.driverList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: adminDashboardController.driverList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, i) {
                      final boy = adminDashboardController.driverList[i];

                      return Obx(() => InkWell(
                          onTap: () {
                            adminDashboardController
                                .selectDeliveryBoy(boy.deliveryBoyId!);
                          },
                          child: Card(
                              color: adminDashboardController
                                      .deliveryIds.isNotEmpty
                                  ? (adminDashboardController
                                                  .deliveryIds.first ==
                                              boy?.deliveryBoyId) ==
                                          true
                                      ? Colors.grey
                                      : Colors.green
                                  : Colors.green,
                              elevation: 10,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => boy!.status! == "Available"
                                        ? SizedBox(
                                            height: 25,
                                            // width: 150,
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Assign",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Checkbox(
                                                    activeColor: Colors.green,
                                                    value: adminDashboardController
                                                            .deliveryIds
                                                            .isNotEmpty
                                                        ? (adminDashboardController
                                                                    .deliveryIds
                                                                    .first ==
                                                                boy.deliveryBoyId)
                                                            ? true
                                                            : false
                                                        : false,
                                                    onChanged: (bool? b) {
                                                      adminDashboardController
                                                          .selectDeliveryBoy(boy
                                                              .deliveryBoyId!);
                                                    }),
                                              ],
                                            ),
                                          )
                                        : const SizedBox()),
                                    // Image.asset(
                                    //   "assets/logo.png",
                                    //   height: 20,
                                    // ),
                                    Text(
                                      boy!.deliveryBoy!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      boy.mobileNo!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      boy.status!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ))));
                    })
                : const SizedBox()),
          ),
          Obx(() => !adminDashboardController.assigningDeliveryOrder.value
              ? ElevatedButton(
                  onPressed: adminDashboardController.deliveryIds.isNotEmpty &&
                          adminDashboardController.listOfIds.isNotEmpty
                      ? () {
                          adminDashboardController.assigningDeliveryBoyOnOrder(
                              adminDashboardController.deliveryIds.first);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    "Assigned Delivery Boy",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
              : const CircularProgressIndicator()),
        ],
      ),
    );
  }
}
