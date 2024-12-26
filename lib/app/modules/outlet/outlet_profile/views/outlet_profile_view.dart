import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/outlet_profile_controller.dart';

class OutletProfileView extends GetView<OutletProfileController> {
  const OutletProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OutletProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OutletProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
