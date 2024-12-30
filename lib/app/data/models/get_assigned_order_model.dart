// To parse this JSON data, do
//
//     final getAssignedOrderModel = getAssignedOrderModelFromJson(jsonString);

import 'dart:convert';

List<GetAssignedOrderModel> getAssignedOrderModelFromJson(String str) => List<GetAssignedOrderModel>.from(json.decode(str).map((x) => GetAssignedOrderModel.fromJson(x)));

String getAssignedOrderModelToJson(List<GetAssignedOrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAssignedOrderModel {
  String? orderId;
  String? orderDate;
  double? payAmount;
  String? paymentOrderId;
  String? name;
  String? mobileNo;
  String? address;
  String? city;
  String? pin;
  String? statename;
  String? status;

  GetAssignedOrderModel({
    this.orderId,
    this.orderDate,
    this.payAmount,
    this.paymentOrderId,
    this.name,
    this.mobileNo,
    this.address,
    this.city,
    this.pin,
    this.statename,
    this.status,
  });

  factory GetAssignedOrderModel.fromJson(Map<String, dynamic> json) => GetAssignedOrderModel(
    orderId: json["OrderId"],
    orderDate: json["OrderDate"],
    payAmount: json["PayAmount"],
    paymentOrderId: json["PaymentOrderId"],
    name: json["Name"],
    mobileNo: json["MobileNo"],
    address: json["Address"],
    city: json["City"],
    pin: json["Pin"],
    statename: json["Statename"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "OrderId": orderId,
    "OrderDate": orderDate,
    "PayAmount": payAmount,
    "PaymentOrderId": paymentOrderId,
    "Name": name,
    "MobileNo": mobileNo,
    "Address": address,
    "City": city,
    "Pin": pin,
    "Statename": statename,
    "Status": status,
  };
}
