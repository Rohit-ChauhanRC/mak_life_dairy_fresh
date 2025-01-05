import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/utils/app_enums/order_enum.dart';
import 'package:mak_life_dairy_fresh/app/utils/utils.dart';

import '../controllers/outlet_order_controller.dart';

class OutletOrderView extends GetView<OutletOrderController> {
  const OutletOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => RichText(
              text: TextSpan(
                text: "Order Id: ",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: controller.newOrderDetail.isNotEmpty
                        ? controller.newOrderDetail.first.orderId.toString()
                        : "",
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )),
        centerTitle: true,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: Get.height * 0.26,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green)),
              child: Obx(() => controller.newOrderDetail.isNotEmpty
                  ? Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                    text: controller
                                        .newOrderDetail.first.customerName,
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
                                text: "MobileNo: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        "${controller.newOrderDetail.first.mobileNo}",
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

                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Customer Address: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: controller
                                        .newOrderDetail.first.customerAddress,
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
                                text: "Shipped From: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: controller
                                        .newOrderDetail.first.shippedFrom,
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
                                text: "Status: ",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 9, 9, 9),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        controller.newOrderDetail.first.status,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                        text: controller
                                            .newOrderDetail.first.orderDate,
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
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: Get.height * 0.40,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green)),
              child: Card(
                elevation: 10,
                child: Obx(() => controller.newOrderDetail.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (ctx, i) => const Divider(),
                        shrinkWrap: true,
                        itemCount: controller.newOrderDetail.length,
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width * .7,
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Product Name: ",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: controller
                                                    .newOrderDetail[i].product,
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Obx(() => controller.orderView.value ==
                                              OrderEnum.preparing
                                          ? Checkbox(
                                              activeColor: Colors.green,
                                              value: controller
                                                  .newOrderDetail[i]
                                                  .isChecked
                                                  .value,
                                              onChanged: (bool? value) {
                                                controller.toggleCheckbox(
                                                    i, value!);
                                              },
                                            )
                                          : Text(
                                              controller.newOrderDetail[i]
                                                          .orderFlag ==
                                                      "Z"
                                                  ? "Rejected"
                                                  : "Accepted",
                                              style: TextStyle(
                                                color: controller
                                                            .newOrderDetail[i]
                                                            .orderFlag ==
                                                        "Z"
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
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
                                        text: "Qty: ",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: controller
                                                .newOrderDetail[i].quantity,
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
                                        text: "Net Amount: ",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                "₹${controller.newOrderDetail[i].payAmount}",
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    double.parse(controller.newOrderDetail[i]
                                                .discountAmt!) !=
                                            0.0
                                        ? RichText(
                                            text: TextSpan(
                                              text: "Discount: ",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "₹${controller.newOrderDetail[i].discountAmt}",
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),

                                const SizedBox(
                                  height: 5,
                                ),
                                // RichText(
                                //   text: const TextSpan(
                                //     text: "CGST/SGST: ",
                                //     style: TextStyle(
                                //       color: Colors.black,
                                //       fontWeight: FontWeight.bold,
                                //       fontSize: 12,
                                //     ),
                                //     children: [
                                //       TextSpan(
                                //         text: "₹97/-",
                                //         style: TextStyle(
                                //           color: Colors.red,
                                //           fontSize: 12,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator())),
              ),
            ),
            Obx(() => controller.orderView.value == OrderEnum.preparing
                ? Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          "Total Amounts: ₹ ${controller.listOfIds.isNotEmpty ? controller.totalAmount : "0.0"}/-"),
                    ),
                  )
                : const SizedBox()),
            Obx(() => controller.orderView.value == OrderEnum.preparing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(() => ElevatedButton(
                          onPressed: controller.listOfIds.isNotEmpty
                              ? () async {
                                  // await controller.rejectOrder();

                                  await controller.verifyOrder();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            "Accept",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ))),
                      ElevatedButton(
                          onPressed: () async {
                            Utils.showDialogYesOrNo(
                                "Are you sure cancel complete order!",
                                onTap: () {
                              controller.orderRejectAll().then((v) {
                                Get.back();
                              });
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            "Complete Cancel Order",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  )
                : const SizedBox()),
          ],
        ),
      ),
    );
  }
}
