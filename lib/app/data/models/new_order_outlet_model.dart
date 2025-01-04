// To parse this JSON data, do
//
//     final newOrderOutletModel = newOrderOutletModelFromJson(jsonString);

import 'dart:convert';

List<NewOrderOutletModel> newOrderOutletModelFromJson(String str) =>
    List<NewOrderOutletModel>.from(
        json.decode(str).map((x) => NewOrderOutletModel.fromJson(x)));

String newOrderOutletModelToJson(List<NewOrderOutletModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewOrderOutletModel {
  String? orderId;
  String? orderDate;
  double? paymentAmount;
  String? paymentOrderId;
  String? name;
  String? mobileNo;
  String? address;
  String? city;
  int? pin;
  String? stateName;
  String? status;
  String? orderTime;
  String? paymentStatus;

  NewOrderOutletModel({
    this.orderId,
    this.orderDate,
    this.paymentAmount,
    this.paymentOrderId,
    this.name,
    this.mobileNo,
    this.address,
    this.city,
    this.pin,
    this.stateName,
    this.status,
    this.orderTime,
    this.paymentStatus,
  });

  factory NewOrderOutletModel.fromJson(Map<String, dynamic> json) =>
      NewOrderOutletModel(
        orderId: json["OrderId"],
        orderDate: json["OrderDate"],
        paymentAmount: json["PaymentAmount"],
        paymentOrderId: json["PaymentOrderId"],
        name: json["Name"],
        mobileNo: json["MobileNo"],
        address: json["Address"],
        city: json["City"],
        pin: json["Pin"],
        stateName: json["StateName"],
        status: json["Status"],
        orderTime: json["Time"],
        paymentStatus: json["PaymentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "OrderDate": orderDate,
        "PaymentAmount": paymentAmount,
        "PaymentOrderId": paymentOrderId,
        "Name": name,
        "MobileNo": mobileNo,
        "Address": address,
        "City": city,
        "Pin": pin,
        "StateName": stateName,
        "Status": status,
        "Time": orderTime,
        "PaymentStatus": paymentStatus,
      };
}
