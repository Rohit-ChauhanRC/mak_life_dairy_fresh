// To parse this JSON data, do
//
//     final getAssignedOrderModel = getAssignedOrderModelFromJson(jsonString);

import 'dart:convert';

List<GetAssignedOrderModel> getAssignedOrderModelFromJson(String str) => List<GetAssignedOrderModel>.from(json.decode(str).map((x) => GetAssignedOrderModel.fromJson(x)));

String getAssignedOrderModelToJson(List<GetAssignedOrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAssignedOrderModel {
  String? orderId;
  String? names;
  String? orderDate;
  String? assignDate;
  String? amount;
  String? shippingFrom;
  double? shippingLatt;
  double? shippingLong;
  String? shippingTo;
  double? pickupLatt;
  double? pickupLong;
  String? deliveryBoy;
  String? deliveryBoyMobile;
  String? time;
  String? custMobile;
  String? paymentStatus;
  String? status;

  GetAssignedOrderModel({
    this.orderId,
    this.names,
    this.orderDate,
    this.assignDate,
    this.amount,
    this.shippingFrom,
    this.shippingLatt,
    this.shippingLong,
    this.shippingTo,
    this.pickupLatt,
    this.pickupLong,
    this.deliveryBoy,
    this.deliveryBoyMobile,
    this.time,
    this.custMobile,
    this.paymentStatus,
    this.status,
  });

  factory GetAssignedOrderModel.fromJson(Map<String, dynamic> json) => GetAssignedOrderModel(
    orderId: json["OrderId"],
    names: json["Names"],
    orderDate: json["OrderDate"],
    assignDate: json["AssignDate"],
    amount: json["Amount"],
    shippingFrom: json["ShippingFrom"],
    shippingLatt: json["ShippingLatt"]?.toDouble(),
    shippingLong: json["shippingLong"]?.toDouble(),
    shippingTo: json["ShippingTo"],
    pickupLatt: json["PickupLatt"]?.toDouble(),
    pickupLong: json["PickupLong"]?.toDouble(),
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
    "AssignDate": assignDate,
    "Amount": amount,
    "ShippingFrom": shippingFrom,
    "ShippingLatt": shippingLatt,
    "shippingLong": shippingLong,
    "ShippingTo": shippingTo,
    "PickupLatt": pickupLatt,
    "PickupLong": pickupLong,
    "DeliveryBoy": deliveryBoy,
    "DeliveryBoyMobile": deliveryBoyMobile,
    "Time": time,
    "CustMobile": custMobile,
    "PaymentStatus": paymentStatus,
    "Status": status,
  };
}
