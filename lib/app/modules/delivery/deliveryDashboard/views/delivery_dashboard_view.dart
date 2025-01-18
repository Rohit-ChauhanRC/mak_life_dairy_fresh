import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_delivery/app/constants/colors.dart';
import 'package:mak_life_delivery/app/widgets/delivery_drawer.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/utils.dart';
import '../controllers/delivery_dashboard_controller.dart';

class DeliveryDashboardView extends GetView<DeliveryDashboardController> {
  const DeliveryDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    // Get.find<DeliveryDashboardController>();
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
            const Text("MAKLIFE DELIVERY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
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
      body: Obx(() {
        return  Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
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
                          Text("${controller.totalOpenOrder}",style: TextStyle(fontWeight: FontWeight.bold,color: blackColor,fontSize: 24)),
                          Text("Open Orders",style: TextStyle(fontWeight: FontWeight.bold,color: blackColor,fontSize: 10))],
                      ),
                    ),
                  ),
                ],
              ),
              Text('Open Orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: blackColor),),

            controller.getOpenOrders.isNotEmpty?
                SizedBox(
                  height: Get.height * 0.750,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      // reverse: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: controller.getOpenOrders.length,
                      itemBuilder: (context,openOrderIndex){
                        var openOrders = controller.getOpenOrders[openOrderIndex];
                        return InkWell(
                          onTap: (){
                            Get.toNamed(Routes.ORDER_DETAILS, arguments: openOrders.orderId);
                          },
                          child: Container(
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
                                      Text("${openOrders.orderId}", style:
                                      TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: blackColor),),
                                      Text("${openOrders.status}", style:
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
                                            child: Text("${openOrders.paymentStatus}", style:
                                            TextStyle(fontSize: 9,fontWeight: FontWeight.bold,color: blackColor),),
                                          ),
                                        ),
                                      ),
                                      // "19 Dec 2024 | 10:53 AM"
                                      Text(Utils.formatDateTime(date: "${openOrders.orderDate}", time: "${openOrders.time}"), style:
                                      TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: blackColor),)
                                    ],),
                                  SizedBox(height: 8,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Delivery Point", style:
                                      TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: blackColor),),
                                      Text("₹ ${openOrders.amount}", style:
                                      TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: blackColor),)
                                    ],),
                                  Text("${openOrders.shippingTo}", style: TextStyle(fontSize: 14,color: blackColor),),
                                  SizedBox(height: 5,),
                                  // Text("Delivery Point", style:
                                  // TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: textBlack),),
                                  // Text("${authRepository.orderListData?[index].deliveryAddress} ${authRepository.orderListData?[index].deliveryCity} ${authRepository.orderListData?[index].deliveryLandmark} ${authRepository.orderListData?[index].deliveryState} ${authRepository.orderListData?[index].deliveryZipcode}",
                                  //   style: TextStyle(fontSize: 14,color: textBlack),)
                                  // Text("Total distance: ${openOrders.distance?.value.toStringAsFixed(2)} km", style:
                                  // TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: blackColor))
                                ],
                              ),
                            ),),
                        );
                      }
                  ),
                )
                    : Padding(
                  padding: EdgeInsets.only(top: Get.height /3),
                  child: Text("You don't have any open orders assigned to you at the moment. Check back later for new delivery jobs.", textAlign: TextAlign.center,),)
            ],
          ),
        );
      }
      )
    );
  }
}
