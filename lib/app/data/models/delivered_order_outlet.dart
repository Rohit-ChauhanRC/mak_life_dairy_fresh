// To parse this JSON data, do
//
//     final deliveredOrderModel = deliveredOrderModelFromJson(jsonString);

import 'dart:convert';

List<DeliveredOrderModel> deliveredOrderModelFromJson(String str) =>
    List<DeliveredOrderModel>.from(
        json.decode(str).map((x) => DeliveredOrderModel.fromJson(x)));

String deliveredOrderModelToJson(List<DeliveredOrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveredOrderModel {
  String? orderId;
  String? names;
  String? orderDate;
  String? deliveredDate;
  String? amount;
  String? shippingFrom;
  String? shippingTo;
  String? deliveryBoy;
  String? deliveryBoyMobile;
  String? time;
  String? custMobile;
  String? paymentStatus;
  String? status;

  DeliveredOrderModel({
    this.orderId,
    this.names,
    this.orderDate,
    this.deliveredDate,
    this.amount,
    this.shippingFrom,
    this.shippingTo,
    this.deliveryBoy,
    this.deliveryBoyMobile,
    this.time,
    this.custMobile,
    this.paymentStatus,
    this.status,
  });

  factory DeliveredOrderModel.fromJson(Map<String, dynamic> json) =>
      DeliveredOrderModel(
        orderId: json["OrderId"],
        names: json["Names"],
        orderDate: json["OrderDate"],
        deliveredDate: json["DeliveredDate"],
        amount: json["Amount"],
        shippingFrom: json["ShippingFrom"],
        shippingTo: json["ShippingTo"],
        deliveryBoy: json["DeliveryBoy"],
        deliveryBoyMobile: json["DeliveryBoyMobile"],
        time: json["Time"],
        custMobile: json["CustMobile"],
        paymentStatus: json["PaymentStatus"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "Names": names,
        "OrderDate": orderDate,
        "DeliveredDate": deliveredDate,
        "Amount": amount,
        "ShippingFrom": shippingFrom,
        "ShippingTo": shippingTo,
        "DeliveryBoy": deliveryBoy,
        "DeliveryBoyMobile": deliveryBoyMobile,
        "Time": time,
        "CustMobile": custMobile,
        "PaymentStatus": paymentStatus,
        "Status": status,
      };
}
