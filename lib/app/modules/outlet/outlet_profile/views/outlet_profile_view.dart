import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/modules/outlet/outlet_profile/widgets/profile_detail.dart';

import '../controllers/outlet_profile_controller.dart';

class OutletProfileView extends GetView<OutletProfileController> {
  const OutletProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Outlet Profile",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: const AssetImage("assets/logo.png"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.green,
                        size: 30,
                      ),
                      onPressed: () {
                        // Add functionality to change profile picture
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Name
            const ProfileDetailRow(
              icon: Icons.person,
              label: "Name",
              value: "Outlet Name", // Replace with dynamic data
            ),
            const Divider(),

            // Address
            const ProfileDetailRow(
              icon: Icons.location_on,
              label: "Address",
              value:
                  "123 Main Street, City, Country", // Replace with dynamic data
            ),
            const Divider(),

            // Phone Number
            const ProfileDetailRow(
              icon: Icons.phone,
              label: "Phone No.",
              value: "+1 234 567 890", // Replace with dynamic data
            ),
            const Divider(),

            // GST Number
            const ProfileDetailRow(
              icon: Icons.receipt,
              label: "GST No.",
              value: "22ABCDE1234F2Z5", // Replace with dynamic data
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
