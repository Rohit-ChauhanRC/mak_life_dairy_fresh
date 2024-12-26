import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/routes/app_pages.dart';

import '../../../../constants/colors.dart';
import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ORDERS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Column(
          children: [
            Obx(()=> orderTypeList()),
            Obx(()=> orderList()),

          ],
        ),
      )
    );
  }
  Widget orderTypeList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){
              controller.isCompleteOrder= false;
              controller.isOpenOrder= true;
          },
          child: Container(
            height: 46,
            width: 110,
            decoration: BoxDecoration(
                color: controller.isOpenOrder?appGreen:lightGrey,
                borderRadius: BorderRadius.circular(25)),child: Center(child: Text("Open", style:
          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: controller.isOpenOrder?whiteColor:blackColor),)),),
        ),
        SizedBox(width: 10,),
        GestureDetector(
          onTap: (){
              controller.isCompleteOrder= true;
              controller.isOpenOrder= false;
          },
          child: Container(
            height: 46,
            width: 110,
            decoration: BoxDecoration(
                color: controller.isCompleteOrder?appGreen:lightGrey,
                borderRadius: BorderRadius.circular(25)),child: Center(child: Text("Completed", style:
          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: controller.isCompleteOrder?whiteColor:blackColor),)),),
        ),
      ],);
  }
  Widget orderList(){
    return SizedBox(
      height: Get.height * 0.824,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          // shrinkWrap: true,
          // physics: AlwaysScrollableScrollPhysics(),
          // itemCount: controller.isOpenOrder?
          // openOrderListData.length>0? openOrderListData.length:1
          //     : closedOrderListData.length>0?closedOrderListData.length:1,
          itemCount: controller.isOpenOrder?2:2,
          itemBuilder: (context,index){
          if(controller.isOpenOrder){
            return InkWell(
              onTap: (){
                Get.toNamed(Routes.ORDER_DETAILS);
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
                ),),
            );}
          else if(controller.isCompleteOrder){
            return InkWell(
              onTap: (){
                Get.toNamed(Routes.ORDER_DETAILS);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(width: 1,color: lightGrey),
                    color: index != 1?Colors.green.withOpacity(0.1):Colors.red.withOpacity(0.1)
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
                          Text(index != 1?"Delivered": 'Cancelled', style:
                          TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: index != 1?Colors.green:Colors.red),)
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
                ),),
            );
          }

          }),
    );
  }
}
