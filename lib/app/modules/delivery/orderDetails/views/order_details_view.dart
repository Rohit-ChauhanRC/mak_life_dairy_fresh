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

          ],
        ),
      )
    );
  }
}
