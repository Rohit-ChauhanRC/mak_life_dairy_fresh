import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/colors.dart';
import '../../../../data/models/get_assigned_order_model.dart';
import '../../../../utils/utils.dart';
import '../controllers/order_report_controller.dart';

class OrderReportView extends GetView<OrderReportController> {
  const OrderReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ORDER REPORT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10.0),
        child: Column(
          children: [
            Obx(()=> dateSelector()),
            Obx(()=> orderList(controller.getFilteredOrder)),
          ],
        ),
      )
    );
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

  Widget orderList(List<GetAssignedOrderModel> orderList,){
    return SizedBox(
      height: Get.height * 0.8,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: orderList.length,
          itemBuilder: (context,orderListIndex){
            return orderList.isNotEmpty ?
            InkWell(
              onTap: (){
                // Get.toNamed(Routes.ORDER_DETAILS, arguments: openOrderList[openAndCompletedIndex].orderId);
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
                          Text("${orderList[orderListIndex].orderId}", style:
                          TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: blackColor),),
                          Text("${orderList[orderListIndex].status}", style:
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
                                child: Text("${orderList[orderListIndex].paymentStatus}", style:
                                TextStyle(fontSize: 9,fontWeight: FontWeight.bold,color: blackColor),),
                              ),
                            ),
                          ),
                          Text(Utils.formatDateTime(date: "${orderList[orderListIndex].orderDate}", time: "${orderList[orderListIndex].time}"), style:
                          TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: blackColor),)
                        ],),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Point", style:
                          TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: blackColor),),
                          Text("₹ ${orderList[orderListIndex].amount}", style:
                          TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: blackColor),)
                        ],),
                      Text("${orderList[orderListIndex].shippingTo}",
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
              child: Text("No orders found for the selected date.", textAlign: TextAlign.center,),);
          }
      ),
    );
  }
}
