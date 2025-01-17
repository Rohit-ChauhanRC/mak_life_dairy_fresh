// To parse this JSON data, do
//
//     final rejectedOrderModel = rejectedOrderModelFromJson(jsonString);

import 'dart:convert';

List<RejectedOrderModel> rejectedOrderModelFromJson(String str) =>
    List<RejectedOrderModel>.from(
        json.decode(str).map((x) => RejectedOrderModel.fromJson(x)));

String rejectedOrderModelToJson(List<RejectedOrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RejectedOrderModel {
  String? orderId;
  String? orderDate;
  String? cancelledDate;
  String? customerName;
  String? mobileNo;
  String? payAmount;
  String? paymentStatus;

  RejectedOrderModel({
    this.orderId,
    this.orderDate,
    this.cancelledDate,
    this.customerName,
    this.mobileNo,
    this.payAmount,
    this.paymentStatus,
  });

  factory RejectedOrderModel.fromJson(Map<String, dynamic> json) =>
      RejectedOrderModel(
        orderId: json["OrderId"],
        orderDate: json["OrderDate"],
        cancelledDate: json["CancelledDate"],
        customerName: json["CustomerName"],
        mobileNo: json["MobileNo"],
        payAmount: json["PayAmount"],
        paymentStatus: json["PaymentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "OrderDate": orderDate,
        "CancelledDate": cancelledDate,
        "CustomerName": customerName,
        "MobileNo": mobileNo,
        "PayAmount": payAmount,
        "PaymentStatus": paymentStatus,
      };
}
