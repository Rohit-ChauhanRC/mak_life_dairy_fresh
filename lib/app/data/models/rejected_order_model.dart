// To parse this JSON data, do
//
//     final rejectedOrderModel = rejectedOrderModelFromJson(jsonString);

import 'dart:convert';

RejectedOrderModel rejectedOrderModelFromJson(String str) =>
    RejectedOrderModel.fromJson(json.decode(str));

String rejectedOrderModelToJson(RejectedOrderModel data) =>
    json.encode(data.toJson());

class RejectedOrderModel {
  String? orderId;
  String? orderDate;
  String? cancelledDate;
  String? customerName;

  RejectedOrderModel({
    this.orderId,
    this.orderDate,
    this.cancelledDate,
    this.customerName,
  });

  factory RejectedOrderModel.fromJson(Map<String, dynamic> json) =>
      RejectedOrderModel(
        orderId: json["OrderId"],
        orderDate: json["OrderDate"],
        cancelledDate: json["CancelledDate"],
        customerName: json["CustomerName"],
      );

  Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "OrderDate": orderDate,
        "CancelledDate": cancelledDate,
        "CustomerName": customerName,
      };
}
