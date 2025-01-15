import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mak_life_delivery/app/data/models/get_assigned_order_model.dart';
import 'package:mak_life_delivery/app/modules/delivery/deliveryDashboard/controllers/delivery_dashboard_controller.dart';
import 'package:mak_life_delivery/app/routes/app_pages.dart';
import 'package:mak_life_delivery/app/utils/utils.dart';

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
      body: GetBuilder<DeliveryDashboardController>(builder: (deliveryDashboardController){
        return Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10.0),
          child: Column(
            children: [
              Obx(()=> orderTypeList()),
              SizedBox(height: 10,),
              Obx(()=> Visibility(
                    visible: controller.isCompleteOrder == true? true: false,
                    child:  dateSelector()),
              ),
              Obx(()=> orderList(deliveryDashboardController.getOpenOrders, controller.getFilteredCompletedOrder)),

            ],
          ),
        );},
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
  Widget dateSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Selected Date: ${DateFormat('dd MMM yyyy').format(controller.selectedDate)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: Get.context!,
              initialDate: controller.selectedDate,
              firstDate: DateTime(2024),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              controller.filterOrdersByAssignDate(pickedDate);
            }
          },
        ),
      ],
    );
  }
  Widget orderList(List<GetAssignedOrderModel> openOrderList, List<GetAssignedOrderModel> completedOrderList ){
    return SizedBox(
      height: controller.isCompleteOrder? Get.height * 0.734: Get.height * 0.79,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: controller.isOpenOrder?
          openOrderList.length>0? openOrderList.length:1
              : completedOrderList.length>0?completedOrderList.length:1,
          itemBuilder: (context,openAndCompletedIndex){
          if(controller.isOpenOrder){
            return openOrderList.isNotEmpty ?
            InkWell(
              onTap: (){
                Get.toNamed(Routes.ORDER_DETAILS, arguments: openOrderList[openAndCompletedIndex].orderId);
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
                          Text("${openOrderList[openAndCompletedIndex].orderId}", style:
                          TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: blackColor),),
                          Text("${openOrderList[openAndCompletedIndex].status}", style:
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
                                child: Text("${openOrderList[openAndCompletedIndex].paymentStatus}", style:
                                TextStyle(fontSize: 9,fontWeight: FontWeight.bold,color: blackColor),),
                              ),
                            ),
                          ),
                          Text(Utils.formatDateTime(date: "${openOrderList[openAndCompletedIndex].orderDate}", time: "${openOrderList[openAndCompletedIndex].time}"), style:
                          TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: blackColor),)
                        ],),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Point", style:
                          TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: blackColor),),
                          Text("₹ ${openOrderList[openAndCompletedIndex].amount}", style:
                          TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: blackColor),)
                        ],),
                      Text("${openOrderList[openAndCompletedIndex].shippingTo}",
                        style: TextStyle(fontSize: 14,color: blackColor),),
                      SizedBox(height: 5,),
                      // Text("Delivery Point", style:
                      // TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: textBlack),),
                      // Text("${authRepository.orderListData?[index].deliveryAddress} ${authRepository.orderListData?[index].deliveryCity} ${authRepository.orderListData?[index].deliveryLandmark} ${authRepository.orderListData?[index].deliveryState} ${authRepository.orderListData?[index].deliveryZipcode}",
                      //   style: TextStyle(fontSize: 14,color: textBlack),)
                    ],
                  ),
                ),),
            )
                :Padding(
              padding: EdgeInsets.only(top: Get.height /3),
              child: Text("You don't have any open orders assigned to you at the moment. Check back later for new delivery jobs.", textAlign: TextAlign.center,),);}
          else if(controller.isCompleteOrder){
            return completedOrderList.isNotEmpty? InkWell(
              onTap: (){
                Get.toNamed(Routes.ORDER_DETAILS, arguments: completedOrderList.reversed.toList()[openAndCompletedIndex].orderId);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(width: 1,color: lightGrey),
                    // color: openAndCompletedIndex != 1?Colors.green.withOpacity(0.1):Colors.red.withOpacity(0.1)
                  color: Colors.green.withOpacity(0.1)
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
                          Text("${completedOrderList.reversed.toList()[openAndCompletedIndex].orderId}", style:
                          TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: blackColor),),
                          Text("${completedOrderList.reversed.toList()[openAndCompletedIndex].status}", style:
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
                                child: Text("${completedOrderList.reversed.toList()[openAndCompletedIndex].paymentStatus}", style:
                                TextStyle(fontSize: 9,fontWeight: FontWeight.bold,color: blackColor),),
                              ),
                            ),
                          ),
                          Text(Utils.formatDateTime(date: "${completedOrderList.reversed.toList()[openAndCompletedIndex].orderDate}", time: "${completedOrderList.reversed.toList()[openAndCompletedIndex].time}"), style:
                          TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: blackColor),)
                        ],),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Point", style:
                          TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: blackColor),),
                          Text("₹ ${completedOrderList.reversed.toList()[openAndCompletedIndex].amount}", style:
                          TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: blackColor),)
                        ],),
                      Text("${completedOrderList.reversed.toList()[openAndCompletedIndex].shippingTo}",
                        style: TextStyle(fontSize: 14,color: blackColor),),
                      SizedBox(height: 5,),
                      // Text("Delivery Point", style:
                      // TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: textBlack),),
                      // Text("${authRepository.orderListData?[index].deliveryAddress} ${authRepository.orderListData?[index].deliveryCity} ${authRepository.orderListData?[index].deliveryLandmark} ${authRepository.orderListData?[index].deliveryState} ${authRepository.orderListData?[index].deliveryZipcode}",
                      //   style: TextStyle(fontSize: 14,color: textBlack),)
                    ],
                  ),
                ),),
            )
                :Padding(
              padding: EdgeInsets.only(top: Get.height /3),
              child: Text("No orders found for the selected date please change the date or you haven't completed any orders yet. Once you finish a delivery, It will appear here.", textAlign: TextAlign.center,),);
          }

          }),
    );
  }
}
