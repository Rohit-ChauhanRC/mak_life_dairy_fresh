import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mak_life_delivery/app/constants/colors.dart';
import 'package:mak_life_delivery/app/data/services/shared_preference_service.dart';

import '../routes/app_pages.dart';

class DeliveryDrawer extends StatelessWidget {
   DeliveryDrawer({super.key});

  final sharedPresencesServices = Get.find<SharedPreferenceService>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green.withOpacity(0.7),
      elevation: 10,
      // width: Get.width / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //profileDetails
          InkWell(
            onTap: (){
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  bottom: 10
              ),
              child: Column(
                children: const[
                  CircleAvatar(
                    radius: 52,
                    backgroundImage: NetworkImage(
                        // 'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNtaWx5JTIwZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c21pbHklMjBmYWNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Name', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),),
                  const Text('@name.com', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600, color: Colors.white),),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          //Home Dashboard Driver
          ListTile(
            onTap: () {
              Get.back();
              Get.toNamed(Routes.DELIVERY_DASHBOARD);
            },
            title: const Text(
              "Home",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            leading: const Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ),
          //OrderList
          ListTile(
            onTap: () {
              Get.back();
              Get.toNamed(Routes.ORDER, arguments: [true, false]);
            },
            title: const Text(
              "Orders",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            leading: ImageIcon(AssetImage("assets/order_icon.png"), color: whiteColor,),
          ),
          //Order Report
          ListTile(
            onTap: () {
              Get.back();
              Get.toNamed(Routes.ORDER_REPORT);
            },
            title: const Text(
              "Compliance Report",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            leading: Icon(Icons.file_copy_rounded, size: 30, color: whiteColor,),
          ),
          //Settings
          ListTile(
            onTap: () {
              Get.back();
              Get.toNamed(Routes.SETTINGS);
            },
            title: const Text(
              "Settings",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            leading: Icon(Icons.settings, size: 30, color: whiteColor,),
          ),
          const Divider(color: Colors.white,),
          //SignOut
          ListTile(
            onTap: () {
              Get.back();
              sharedPresencesServices.clear().then((onValue){
                Get.offAllNamed(Routes.VERIFY_PHONE_NUMBER);
              });
            },
            title: const Text(
              "Sign Out",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            leading: Icon(Icons.login_outlined, color: whiteColor, size: 30,),
          ),
        ],
      ),

    );
  }
}
