import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh_delivery/app/constants/colors.dart';

import '../../../constants/constants.dart';
import '../controllers/verify_phone_number_controller.dart';

class VerifyPhoneNumberView extends GetView<VerifyPhoneNumberController> {
  const VerifyPhoneNumberView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                  items: controller.imageUrls.map((url) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.asset(
                          url,
                          fit: BoxFit.contain,
                          width: Get.width,
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 300.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      controller.current = index;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          controller.imageUrls.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => controller.current = entry.key,
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.green,
                              ),
                              color: controller.current == entry.key
                                  ? Colors.green
                                  : Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 10,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            verifyNumberTextForShowing,
                            textAlign: TextAlign.left,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: blackColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      SizedBox(
                        width: Get.width * 0.8,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (v) => controller.mobileNumber = v,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: whiteColor,
                              prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 14, bottom: 10),
                                  child: Image.asset("assets/flag.png")),
                              hintText: 'Enter mobile number',
                              hintStyle: const TextStyle(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200)),
                          validator: (value) => value!.length != 10
                              ? "Please enter valid mobile number!"
                              : null,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Obx(() => controller.circularProgress
                          ? SizedBox(
                              width: Get.width * 0.8,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    // padding: const EdgeInsets.only(
                                    //     left: 60, right: 60),
                                    backgroundColor: const Color(0xff09AB47)),
                                onPressed: () {
                                  controller.login();
                                  // Get.toNamed(Routes.HOME, arguments: "1002");
                                },
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: textBarColor,
                              ),
                            )),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                          top: 10,
                        ),
                        child: const Text(
                          'By Signing up you agree to \n\t\t TnC and Privacy Policy',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
