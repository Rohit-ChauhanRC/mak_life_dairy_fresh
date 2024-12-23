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
        child: ListView(
          shrinkWrap: true,
          children: [],
        ),
      ),
    );
  }
}
