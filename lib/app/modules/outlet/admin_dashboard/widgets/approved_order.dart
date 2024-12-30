import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/data/models/verified_order_outlet.dart';
import 'package:mak_life_dairy_fresh/app/modules/outlet/admin_dashboard/controllers/admin_dashboard_controller.dart';
import 'package:mak_life_dairy_fresh/app/routes/app_pages.dart';

class ApprovedOrder extends StatelessWidget {
  const ApprovedOrder({super.key, required this.adminDashboardController});

  final AdminDashboardController adminDashboardController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Get.height * .5,
            width: Get.width,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green)),
            child: Obx(() => adminDashboardController.verifiedOrder.isNotEmpty
                ? ListView.builder(
                    itemCount: adminDashboardController.verifiedOrder.length,
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
                                  text: "Date & Time: ",
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
                            ],
                          ),
                        ),
                      );
                    })
                : const SizedBox()),
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.all(10),
            width: Get.width,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green)),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) {
                  // final order = controller.orderList[i];
                  return InkWell(
                      onTap: () {
                        // controller.orderStatus = order;
                      },
                      child: Card(
                        // margin: const EdgeInsets.only(
                        //   left: 30,
                        //   bottom: 5,
                        // ),
                        color: Colors.green,
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Align(
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/logo.png",
                                  height: 20,
                                ),
                                const Text(
                                  "Name1",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                                const Text(
                                  "MOB",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                                const Text(
                                  "Avaialable",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                }),
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Assigned Delivery Boy",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }
}
