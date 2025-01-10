import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_delivery/app/constants/colors.dart';
import 'package:mak_life_delivery/app/routes/app_pages.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SETTINGS',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userDetails(),
                //Notifications
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: blackColor),
                        ),
                        InkWell(
                          onTap: (){
                            Get.toNamed(Routes.DRIVER_NOTIFICATION);
                          },
                          child: Text(
                            "View Notifications",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: blackColor),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                //Help Center
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Help Center",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: blackColor),
                          ),
                        ),
                        Text(
                          "FAQ (Frequently Asked Questions)",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: blackColor),
                        ),
                        SizedBox(height: 10,),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                //Legal
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Legal",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: blackColor),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Driver Contract",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor),
                            ),
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            footer(),
          ],
        ),
      )
    );
  }
  Widget userDetails(){
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c21pbHklMjBmYWNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
            width: 43, height: 43, fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                        fontSize: 19),
                  ),
                ],
              ),
              Text(
                "@name.com",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                    fontSize: 12),
              ),
              Text(
                "+91 8989899989",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget footer(){
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Logout
          InkWell(
            onTap: (){
              controller.logout();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logout.png',
                  height: 18,
                  width: 22,
                ),
                SizedBox(width: 10,),
                Text(
                  "Sign Out",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.black),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          //Version
          Text(
            "Version: 1.0",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 17,
                color: blackColor),
          ),
          SizedBox(height: 20,),
          //PoweredBy
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/genMakLogo.png",
                width: 50,
                height: 50,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Powered by',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                        height: 0.1),
                  ),
                  Text(
                    'Genmak',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textBarColor),
                  )
                ],
              )
            ],
          )
        ],
      ),

    );
  }
}
