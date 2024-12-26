import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/outline_add_delivery_boy_controller.dart';

class OutlieAddDeliveryBoyView
    extends GetView<OutlineAddDeliveryBoyController> {
  const OutlieAddDeliveryBoyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add DeliveryBoy'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OutlieAddDeliveryBoyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
