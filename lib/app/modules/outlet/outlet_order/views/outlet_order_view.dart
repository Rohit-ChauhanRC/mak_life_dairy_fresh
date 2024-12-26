import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/routes/app_pages.dart';

import '../controllers/outlet_order_controller.dart';

class OutletOrderView extends GetView<OutletOrderController> {
  const OutletOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outlet Order'),
        centerTitle: true,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            RichText(
              text: const TextSpan(
                text: "Order Id: ",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: Get.height * 0.4,
              child: Card(
                elevation: 10,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.items.length,
                  itemBuilder: (ctx, i) {
                    return Obx(() => CheckboxListTile(
                          activeColor: Colors.green,
                          title: Text(controller.items[i]['label']),
                          value: controller.items[i]['isChecked'],
                          onChanged: (bool? value) {
                            controller.toggleCheckbox(i, value!);
                          },
                        ));
                  },
                ),
              ),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Total Amounts: ₹ 2000/-"),
              ),
            ),
            Container(
              height: 150,
              margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              width: Get.width,
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
                          margin: const EdgeInsets.only(
                            left: 30,
                            bottom: 5,
                          ),
                          color: Colors.green,
                          elevation: 10,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Align(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/logo.png",
                                    height: 50,
                                  ),
                                  const Text(
                                    "Name1",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "MOB",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Avaialable",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Accept",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      "Reject",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
