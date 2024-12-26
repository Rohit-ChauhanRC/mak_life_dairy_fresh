import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
          ],
        ),
      ),
    );
  }
}
