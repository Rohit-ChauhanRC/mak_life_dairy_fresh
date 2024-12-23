import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/outlet_notifications_controller.dart';

class OutletNotificationsView extends GetView<OutletNotificationsController> {
  const OutletNotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
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
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                      const Text("New Order"),
                      Text(
                        DateFormat.yMd().format(DateTime.now()),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
