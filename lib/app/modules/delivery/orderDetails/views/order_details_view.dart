import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mak_life_delivery/app/constants/colors.dart';
import 'package:mak_life_delivery/app/modules/delivery/orderDetails/Widgets/delivery_comfirmation_popup.dart';
import 'package:mak_life_delivery/app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/alert_popup_utils.dart';
import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ORDER DETAILS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        centerTitle: true,
      ),
      body: Obx(
          ()=> SingleChildScrollView(
          padding: EdgeInsets.only(left: 18, right: 18, top: 10),
          child: !controller.circularProgress ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator(color: appGreen,),)):Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order No: ${controller.getAssignedOrderDetails.orderId}", style:
              TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: blackColor),),
              SizedBox(height: 10,),
              Text("Pickup", style:
              TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: Get.width * 0.7,
                      child: Text("${controller.getAssignedOrderDetails.pickupAddress}", style: TextStyle(fontSize: 16, color: blackColor),)),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            controller.redirectToGoogleMaps(controller.pickUpPosition);
                            controller.updateCameraPosition(controller.pickUpPosition);
                          },
                          child: Icon(Icons.location_on_outlined,color: Colors.red,)),
                      SizedBox(width: 10,),
                      GestureDetector(
                          onTap: (){
                            var pickupPhoneNo = controller.getAssignedOrderDetails.pickupPhoneno;
                            launch('tel:$pickupPhoneNo');
                          },
                          child: Image.asset("assets/callwithGreenBg.png",width: 30, height: 30,)),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10,),
              Text("Delivery", style:
              TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: Get.width * 0.7,
                      child: Text("${controller.getAssignedOrderDetails.deliveryAddress}", style: TextStyle(fontSize: 16, color: blackColor),)),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            controller.redirectToGoogleMaps(controller.destinationPosition);
                            controller.updateCameraPosition(controller.destinationPosition);
                          },
                          child: Icon(Icons.location_on_outlined,color: Colors.green,)),
                      SizedBox(width: 10,),
                      GestureDetector(
                          onTap: (){
                            var deliveryPhoneNo = controller.getAssignedOrderDetails.deliveryPhone;
                            launch('tel:$deliveryPhoneNo');
                          },
                          child: Image.asset("assets/callwithGreenBg.png",width: 30, height: 30,)),
                    ],
                  )
                ],
              ),
              SizedBox(height: 16,),
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Obx(()=>GoogleMap(
                        initialCameraPosition: CameraPosition(
                          // target: orderDetailsProvider.orderListData?.first.currentStatusName=="Pick Up in Progress"?_pickUpPosition!:_destinationPosition!,
                          target: controller.destinationPosition,
                          zoom: 12.0,
                        ),
                      markers: {
                        Marker(
                            markerId: MarkerId('_sourceLocation'),
                            position: controller.pickUpPosition,
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
                        ),
                        Marker(
                            markerId: MarkerId('_destinationLocation'),
                            position: controller.destinationPosition,
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
                        ),
                      },
                      polylines: Set<Polyline>.of(controller.polyLines.values),
                      onMapCreated: (GoogleMapController mapController) {
                          if(controller.mapController != null){
                            controller.mapController.complete(mapController);
                          }
                        }

                      ),
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: appGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Customer Detail", style:
                    TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: blackColor),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: Image.asset("assets/person_dummy.png",width: 34,height: 34,)),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${controller.getAssignedOrderDetails.customerName}", style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: blackColor),),
                              Text("${controller.getAssignedOrderDetails.deliveryPhone}",style:
                              TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: blackColor),)
                            ],),
                        ],),
                        GestureDetector(
                            onTap: () => launch('tel:${controller.getAssignedOrderDetails.deliveryPhone}'),
                            child: Image.asset('assets/callwithGreenBg.png',width: 33,height: 33,)),
                      ],)
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("Product Detail", style:
                      TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: blackColor),),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.getAssignedOrderDetails.productItems?.length,
                      itemBuilder: (context, productIndex){
                        var productDetails = controller.getAssignedOrderDetails.productItems?[productIndex];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    // child: Image.asset("assets/person_dummy.png",width: 40,height: 40,)
                                  child: Image.network("${productDetails?.productImage}", width: 50, height: 70,),
                                    ),
                                SizedBox(width: 10,),
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${productDetails?.productName}", maxLines: 2, style:
                                      TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: blackColor),),
                                      Text("${productDetails?.productDesc}",style:
                                      TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: blackColor),),
                                      // Text("₹ ${productDetails?.productPrice}",style:
                                      // TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: blackColor),),
                                      SizedBox(height: 10,)
                                    ],),
                                )
                              ],
                            ),
                            Text("Qty: ${productDetails?.productQuantity}", style:
                            TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: blackColor),)
                          ],
                        );
                      }),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Text("Payment Detail",style:
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: blackColor),),
              SizedBox(height: 10,),
              Obx(()=> Visibility(
                  visible: controller.isPaymentDetailVisible,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total item Cost", style:
                          TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                          Text("₹ ${controller.getAssignedOrderDetails.orderAmount}", style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),)
                        ],),
                      // //OrderTax
                      // SizedBox(height: 10,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text("Tax", style:
                      //     TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                      //     Text("₹ 200.00", style:
                      //     TextStyle(fontSize: 14, fontWeight: FontWeight.w700),)
                      //   ],),
                      // SizedBox(height: 10,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text("Discount", style:
                      //     TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                      //     Text("₹ -${controller.getAssignedOrderDetails.orderDiscount}", style:
                      //     TextStyle(fontSize: 14, fontWeight: FontWeight.w700),)
                      //   ],),
                      SizedBox(height: 10,),
                      Divider(height: 1,color: Colors.grey,),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Amount", style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                          Text("₹ ${controller.getAssignedOrderDetails.orderAmount}", style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),)
                        ],),
                      Text("*Including Delivery charges", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w400, color: blackColor),),
                      SizedBox(height: 10,),
                      Divider(height: 1,color: Colors.grey,),
                    ],
                  ),
                ),),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10, right: Get.height*0.18),
                padding: EdgeInsets.only(top: 10, right: 14, left: 14, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount", style:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                    SizedBox(width: 17,),
                    Text("₹ ${controller.getAssignedOrderDetails.orderAmount}", style:
                    TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap: () {
                          controller.isPaymentDetailVisible = !controller.isPaymentDetailVisible;
                          },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset("assets/info.png",width: 20,height: 20,),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                  ()=> Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order Detail", style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            GestureDetector(
                                onTap: (){
                                    controller.isOrderStatusVisible = !controller.isOrderStatusVisible;
                                },
                                child: RotationTransition(
                                    turns: AlwaysStoppedAnimation(controller.isOrderStatusVisible?360:180/360),
                                    child: Image.asset('assets/drop-up-arrow.png',height: 24,width: 24, )))
                          ],
                        ),

                        Visibility(
                          visible: controller.isOrderStatusVisible,
                          child: ListView.builder(
                              reverse: true,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.getAssignedOrderDetails.notes?.length,
                              itemBuilder: (context, notesIndex){
                                var orderUpdateDetails = controller.getAssignedOrderDetails.notes?[notesIndex];
                                return Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Container(height: 30,width: 1,
                                          decoration: BoxDecoration(color:
                                          controller.getAssignedOrderDetails.notes!.length -1 ==notesIndex?Colors.green.withOpacity(0):
                                          blackColor),
                                        ),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(height: 30,width: 0,
                                            decoration: BoxDecoration(color:
                                            controller.getAssignedOrderDetails.notes!.length-1==notesIndex?Colors.green.withOpacity(0):
                                            blackColor),
                                          ),
                                          Image.asset('assets/checkCircle.png',width: 21,height: 21,),
                                          Visibility(
                                            visible: controller.isOrderStatusVisible,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 10,left: 10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${orderUpdateDetails?.action?[0].toUpperCase()}${orderUpdateDetails?.action?.substring(1).toLowerCase()} ",style:
                                                  TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                  Text(Utils.formatIsoDateTime(isoDateTime: orderUpdateDetails!.createdDate.toString()),style:
                                                  TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Obx(
                ()=> Visibility(
                  visible: controller.orderCurrentStatusName == "ASSIGNED" || controller.orderCurrentStatusName == "TRANSIT"? true: false,
                  child: ElevatedButton(
                      onPressed: (){
                        if(controller.orderCurrentStatusName == "ASSIGNED"){
                          showAlertForPickUp(context, "Order Picked up successfully.", controller, controller.getAssignedOrderDetails.orderId.toString());
                        }else if(controller.orderCurrentStatusName == "TRANSIT"){
                          // Get.to(SuccessfullyDelivery(orderID: "1000001",));
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context)=>DeliveryConfirmationPopup(orderId: controller.getAssignedOrderDetails.orderId.toString(),));
                        }
                      },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(Get.width, 50),
                    backgroundColor: appGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                      child: Text(controller.orderCurrentStatusName == "ASSIGNED"?'Mark as picked up':'Mark as Delivered', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),)
                  ),
                ),
              ),
              SizedBox(height: 16,),
            ],
          ),
        ),
      )
    );
  }
}
