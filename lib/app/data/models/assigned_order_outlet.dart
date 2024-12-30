// To parse this JSON data, do
//
//     final assignedOrderDetailOutletModel = assignedOrderDetailOutletModelFromJson(jsonString);

import 'dart:convert';

List<AssignedOrderDetailOutletModel> assignedOrderDetailOutletModelFromJson(
        String str) =>
    List<AssignedOrderDetailOutletModel>.from(json
        .decode(str)
        .map((x) => AssignedOrderDetailOutletModel.fromJson(x)));

String assignedOrderDetailOutletModelToJson(
        List<AssignedOrderDetailOutletModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssignedOrderDetailOutletModel {
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
  String? assingDate;
  String? status;

  AssignedOrderDetailOutletModel({
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
    this.assingDate,
    this.status,
  });

  factory AssignedOrderDetailOutletModel.fromJson(Map<String, dynamic> json) =>
      AssignedOrderDetailOutletModel(
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
        assingDate: json["AssingDate"],
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
        "AssingDate": assingDate,
        "Status": status,
      };
}
