import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/constants/colors.dart';

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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: controller.createProfileKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: controller.selectImage,
                  child: Obx(() => controller.image != null
                      ? CircleAvatar(
                          backgroundColor: greyColor.withOpacity(0.4),
                          backgroundImage: FileImage(
                            controller.image!,
                          ),
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundColor: greyColor.withOpacity(0.4),
                          backgroundImage: Image.asset("assets/logo.png").image,
                          radius: 64,
                        )),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: controller.profileNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (v) => controller.profileName = v,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                  cursorColor: textBarColor,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter name!" : null,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // controller: controller.profileNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (v) => controller.mobileNumber = v,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Phone number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                  cursorColor: textBarColor,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter phone number!" : null,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // controller: controller.profileNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (v) => controller.bankAc = v,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_balance),
                    hintText: 'Bank Account',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                  cursorColor: textBarColor,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter bank number!" : null,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // controller: controller.profileNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (v) => controller.ifscCode = v,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_balance_wallet),
                    hintText: 'IFSC Code',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                  cursorColor: textBarColor,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter ifsc code!" : null,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // controller: controller.profileNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (v) => controller.vehicleNo = v,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.airport_shuttle_outlined),
                    hintText: 'Vehicle Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                  cursorColor: textBarColor,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter vehicle number!" : null,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // controller: controller.profileNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (v) => controller.licenseNo = v,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.credit_card_outlined),
                    hintText: 'License Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                  cursorColor: textBarColor,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter license number!" : null,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // controller: controller.profileNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (v) => controller.address = v,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.home_outlined),
                    hintText: 'Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                  cursorColor: textBarColor,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter address!" : null,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => !controller.circularProgress
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: textBarColor,
                          ),
                        )
                      : SizedBox(
                          width: Get.width * 0.8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: controller.createProfile,
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor),
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
