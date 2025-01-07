import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh_delivery/app/constants/colors.dart';

import '../../../../routes/app_pages.dart';

class SuccessfullyDelivery extends StatefulWidget {
  String? orderID;
  SuccessfullyDelivery({super.key, this.orderID});

  @override
  State<SuccessfullyDelivery> createState() => _SuccessfullyDeliveryState();
}

class _SuccessfullyDeliveryState extends State<SuccessfullyDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/dropOrder.png",height: 180,width: 180,),
            const Text("Order delivered successfully",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24,color: blackColor),),
            Text("Order ${widget.orderID}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: blackColor)),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Get.until((route) => route.settings.name == Routes.DELIVERY_DASHBOARD);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(Get.width, 50),
                backgroundColor: appGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text("Continue", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
