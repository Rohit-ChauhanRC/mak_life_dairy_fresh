import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../constants/colors.dart';

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