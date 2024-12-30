// To parse this JSON data, do
//
//     final verifiedOrderDetailOutletModel = verifiedOrderDetailOutletModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<VerifiedOrderDetailOutletModel> verifiedOrderDetailOutletModelFromJson(
        String str) =>
    List<VerifiedOrderDetailOutletModel>.from(json
        .decode(str)
        .map((x) => VerifiedOrderDetailOutletModel.fromJson(x)));

String verifiedOrderDetailOutletModelToJson(
        List<VerifiedOrderDetailOutletModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VerifiedOrderDetailOutletModel {
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
  RxBool isChecked;

  VerifiedOrderDetailOutletModel({
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
    required bool isChecked,
  }) : isChecked = RxBool(isChecked);

  factory VerifiedOrderDetailOutletModel.fromJson(Map<String, dynamic> json) =>
      VerifiedOrderDetailOutletModel(
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
        isChecked: false,
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
      };
}
