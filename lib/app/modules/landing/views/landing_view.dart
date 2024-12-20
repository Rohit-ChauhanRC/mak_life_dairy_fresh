import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Image.asset(
          "assets/vi2.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
