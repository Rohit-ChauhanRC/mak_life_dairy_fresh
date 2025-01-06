// To parse this JSON data, do
//
//     final driverListModel = driverListModelFromJson(jsonString);

import 'dart:convert';

List<DriverListModel> driverListModelFromJson(String str) =>
    List<DriverListModel>.from(
        json.decode(str).map((x) => DriverListModel.fromJson(x)));

String driverListModelToJson(List<DriverListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DriverListModel {
  String? deliveryBoyId;
  String? deliveryBoy;
  String? mobileNo;
  String? outletNo;
  String? imagePath;
  String? vehicleno;
  String? status;

  DriverListModel({
    this.deliveryBoyId,
    this.deliveryBoy,
    this.mobileNo,
    this.outletNo,
    this.imagePath,
    this.vehicleno,
    this.status,
  });

  factory DriverListModel.fromJson(Map<String, dynamic> json) =>
      DriverListModel(
        deliveryBoyId: json["DeliveryBoyId"],
        deliveryBoy: json["DeliveryBoy"],
        mobileNo: json["MobileNo"],
        outletNo: json["OutletNo"],
        imagePath: json["ImagePath"],
        vehicleno: json["Vehicleno"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "DeliveryBoyId": deliveryBoyId,
        "DeliveryBoy": deliveryBoy,
        "MobileNo": mobileNo,
        "OutletNo": outletNo,
        "ImagePath": imagePath,
        "Vehicleno": vehicleno,
        "Status": status,
      };
}
