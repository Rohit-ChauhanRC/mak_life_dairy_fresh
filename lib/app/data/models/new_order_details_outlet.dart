// To parse this JSON data, do
//
//     final newOrderDetailOutletModel = newOrderDetailOutletModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<NewOrderDetailOutletModel> newOrderDetailOutletModelFromJson(String str) =>
    List<NewOrderDetailOutletModel>.from(
        json.decode(str).map((x) => NewOrderDetailOutletModel.fromJson(x)));

String newOrderDetailOutletModelToJson(List<NewOrderDetailOutletModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewOrderDetailOutletModel {
  String? orderId;
  String? orderDate;
  String? productCode;
  String? product;
  String? quantity;
  String? payAmount;
  String? paymentOrderId;
  String? customerName;
  String? mobileNo;
  String? customerAddress;
  String? shippedFrom;
  String? latt;
  String? long;
  String? status;
  RxBool isChecked;

  NewOrderDetailOutletModel({
    this.orderId,
    this.orderDate,
    this.productCode,
    this.product,
    this.quantity,
    this.payAmount,
    this.paymentOrderId,
    this.customerName,
    this.mobileNo,
    this.customerAddress,
    this.shippedFrom,
    this.latt,
    this.long,
    this.status,
    required bool isChecked,
  }) : isChecked = RxBool(isChecked);

  factory NewOrderDetailOutletModel.fromJson(Map<String, dynamic> json) =>
      NewOrderDetailOutletModel(
        orderId: json["OrderId"],
        orderDate: json["OrderDate"],
        productCode: json["ProductCode"],
        product: json["Product"],
        quantity: json["Quantity"],
        payAmount: json["PayAmount"],
        paymentOrderId: json["PaymentOrderId"],
        customerName: json["CustomerName"],
        mobileNo: json["MobileNo"],
        customerAddress: json["CustomerAddress"],
        shippedFrom: json["ShippedFrom"],
        latt: json["Latt"],
        long: json["Long"],
        status: json["Status"],
        isChecked: true,
      );

  Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "OrderDate": orderDate,
        "ProductCode": productCode,
        "Product": product,
        "Quantity": quantity,
        "PayAmount": payAmount,
        "PaymentOrderId": paymentOrderId,
        "CustomerName": customerName,
        "MobileNo": mobileNo,
        "CustomerAddress": customerAddress,
        "ShippedFrom": shippedFrom,
        "Latt": latt,
        "Long": long,
        "Status": status,
      };
}
