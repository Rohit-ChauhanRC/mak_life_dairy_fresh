import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/delivery_dashboard_controller.dart';

class DeliveryDashboardView extends GetView<DeliveryDashboardController> {
  const DeliveryDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliveryDashboardView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DeliveryDashboardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
