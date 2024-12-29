import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/constants/colors.dart';
import 'package:mak_life_dairy_fresh/app/widgets/delivery_drawer.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/delivery_dashboard_controller.dart';

class DeliveryDashboardView extends GetView<DeliveryDashboardController> {
  const DeliveryDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DeliveryDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: Image.asset("assets/logo.png").image,
              radius: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text("MAKLIFE DAIRY FRESH", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.DRIVER_NOTIFICATION);
            },
            child: const Icon(
              Icons.notifications_active_rounded, color: appGreen,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello", style:
                      TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: blackColor),),
                      Text("Name", style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: blackColor),),
                    ],
                  ),
                  GestureDetector(
                    onTap: ()=> {
                      Get.toNamed(Routes.ORDER, arguments: [true, false]),
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 18),
                      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3),borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Text("1",style: TextStyle(fontWeight: FontWeight.bold,color: blackColor,fontSize: 24)),
                          Text("Open Orders",style: TextStyle(fontWeight: FontWeight.bold,color: blackColor,fontSize: 10))],
                      ),
                    ),
                  ),
                ],
              ),
              Text('Open Orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: blackColor),),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount:2,
                  itemBuilder: (context,openOrderIndex){
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(width: 1,color: Colors.grey)
                      ),
                      margin: EdgeInsets.only(left: 0,right: 0,top: 8,bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Order #id", style:
                                TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: blackColor),),
                                Text("Order Status", style:
                                TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.green),)
                              ],),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: greyColor.withOpacity(0.2)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                                      child: Text("paymentType", style:
                                      TextStyle(fontSize: 9,fontWeight: FontWeight.bold,color: blackColor),),
                                    ),
                                  ),
                                ),
                                Text("19 Dec 2024 | 10:53 AM", style:
                                TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: blackColor),)
                              ],),
                            SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery Point", style:
                                TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: blackColor),),
                                Text("₹ 200.00", style:
                                TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: blackColor),)
                              ],),
                            Text("5th floor, Unit No: 516, Spaze I-Tech park, sector 49, 201011",
                              style: TextStyle(fontSize: 14,color: blackColor),),
                            SizedBox(height: 5,),
                            // Text("Delivery Point", style:
                            // TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: textBlack),),
                            // Text("${authRepository.orderListData?[index].deliveryAddress} ${authRepository.orderListData?[index].deliveryCity} ${authRepository.orderListData?[index].deliveryLandmark} ${authRepository.orderListData?[index].deliveryState} ${authRepository.orderListData?[index].deliveryZipcode}",
                            //   style: TextStyle(fontSize: 14,color: textBlack),)
                          ],
                        ),
                      ),);
                  }
              )
            ],
          ),
        ),
      )
    );
  }
}
