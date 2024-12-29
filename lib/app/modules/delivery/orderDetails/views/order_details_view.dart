import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mak_life_dairy_fresh/app/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 18, right: 18, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order #23456", style:
            TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: blackColor),),
            SizedBox(height: 10,),
            Text("Pickup", style:
            TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: Get.width * 0.7,
                    child: Text("5th floor, Unit No: 516, Spaze I-Tech park, sector 49, 201011", style: TextStyle(fontSize: 16, color: blackColor),)),
                Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          controller.updateCameraPosition(controller.pickUpPosition);
                        },
                        child: Icon(Icons.location_on_outlined,color: Colors.red,)),
                    SizedBox(width: 10,),
                    GestureDetector(
                        onTap: (){
                          launch('tel:9140363633');
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
                    child: Text("5th floor, Unit No: 516, Spaze I-Tech park, sector 49, 201011", style: TextStyle(fontSize: 16, color: blackColor),)),
                Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          controller.updateCameraPosition(controller.destinationPosition);
                        },
                        child: Icon(Icons.location_on_outlined,color: Colors.green,)),
                    SizedBox(width: 10,),
                    GestureDetector(
                        onTap: (){
                          launch('tel:9140363633');
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
                        target: controller.pickUpPosition,
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
                            Text("Customer Name", style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: blackColor),),
                            Text("Coustomer details",style:
                            TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: blackColor),)
                          ],),
                      ],),
                      GestureDetector(
                          onTap: () => launch('tel:9140363633'),
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
                    itemCount: 5,
                    itemBuilder: (context, productIndex){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset("assets/person_dummy.png",width: 40,height: 40,)),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("product Name", style:
                                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: blackColor),),
                                  Text("products details",style:
                                  TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: blackColor),),
                                  SizedBox(height: 10,)
                                ],)
                            ],
                          ),
                          Text("Quantity: 1", style:
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total item Cost", style:
                        TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                        Text("₹ 200.00", style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w700),)
                      ],),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tax", style:
                        TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                        Text("₹ 200.00", style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w700),)
                      ],),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount", style:
                        TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                        Text("₹ - 100.00", style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w700),)
                      ],),
                    SizedBox(height: 10,),
                    Divider(height: 1,color: Colors.grey,),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount", style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                        Text("₹ 200.00", style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w700),)
                      ],),
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
                  Text("₹ 200", style:
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
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index){

                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Container(height: 30,width: 1,
                                        decoration: BoxDecoration(color:
                                        // orderDetailsData.first.notes!.length-1==index?Colors.green.withOpacity(0):
                                        -1==index?Colors.green.withOpacity(0):
                                        blackColor),
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(height: 30,width: 0,
                                          decoration: BoxDecoration(color:
                                          // orderDetailsProvider.orderListData!.first.notes!.length-1==index?Colors.green.withOpacity(0):
                                          -1==index?Colors.green.withOpacity(0):
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
                                                Text("Pick Up in Progress",style:
                                                TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                Text("23 Dec 2024 | 06:23 AM",style:
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
            ElevatedButton(
                onPressed: (){}, 
                child: Text('Pick Up in Progress', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(Get.width, 50),
              backgroundColor: appGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            )
            ),
            SizedBox(height: 16,),
          ],
        ),
      )
    );
  }
}
