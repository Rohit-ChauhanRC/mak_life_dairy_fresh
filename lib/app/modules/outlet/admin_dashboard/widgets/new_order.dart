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
      child: ListView.builder(
          itemCount: 10,
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
                          text: const TextSpan(
                            text: "Order Id: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: "#121223213",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: "Total Amount: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: "₹2900/-",
                                style: TextStyle(
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
                      text: const TextSpan(
                        text: "Customer Name: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: "Vijay Dena Nath Chauhan",
                            style: TextStyle(
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
                          text: const TextSpan(
                            text: "Date: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: "29Dec,2024",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            text: "Time: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: "12:32 PM",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                          Get.toNamed(Routes.OUTLET_ORDER);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
