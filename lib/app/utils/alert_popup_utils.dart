import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

import '../../main.dart';
import '../constants/colors.dart';
import '../modules/delivery/orderDetails/controllers/order_details_controller.dart';

void showAlertMessage( String message) {
  final context = navigatorKey.currentContext;

  if (context == null) {
    print('Context is not available:-------------------------------> Getting error for showing popup');
    return;
  }
  showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Maklife Dairy Fresh"),
        content: Text(message, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: blackColor),),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            isDefaultAction: true,
            child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Text("OK", style: TextStyle(color: appGreen))),
          )
        ],
      ));
}

void showAlertForPickUp(BuildContext context, String message,
    OrderDetailsController orderDetailsController, String orderId) {
  showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title:  const Text("Maklife Dairy Fresh"),
        content:  Text(message, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: blackColor)),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              // orderDetailsController.orderCurrentStatusName = "TRANSIT";
              Get.back();
              orderDetailsController.updateOrderStatusAPI(orderId, "T");
              // orderProvider
              //     .getOrderListApiCall(context, oderId ?? 0, 0,
              //     userDefault.read(USERID), 0, "", 1);
            },
            child: Text("OK", style: TextStyle(color: appGreen)),
          )
        ],
      ));
}


void showAlertFileSavedDialog(BuildContext context, String message, String filePath) {
  showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title:  const Text("Maklife Dairy Fresh"),
        content:  Text(message, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: blackColor)),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            child: Text("Close", style: TextStyle(color: blackColor)),
          ),
          CupertinoDialogAction(
            onPressed: () async{
              Get.back();
              await OpenFile.open(filePath);
            },
            child: Text("Open", style: TextStyle(color: appGreen)),
          )
        ],
      ));
}
