// To parse this JSON data, do
//
//     final getAssignedOrderDetailsModel = getAssignedOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

GetAssignedOrderDetailsModel getAssignedOrderDetailsModelFromJson(String str) => GetAssignedOrderDetailsModel.fromJson(json.decode(str));

String getAssignedOrderDetailsModelToJson(GetAssignedOrderDetailsModel data) => json.encode(data.toJson());

class GetAssignedOrderDetailsModel {
  String? status;
  int? statusCode;
  String? message;
  List<GetAssignedDetails>? data;

  GetAssignedOrderDetailsModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetAssignedOrderDetailsModel.fromJson(Map<String, dynamic> json) => GetAssignedOrderDetailsModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? [] : List<GetAssignedDetails>.from(json["data"]!.map((x) => GetAssignedDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetAssignedDetails {
  String? orderId;
  int? driverId;
  int? customerId;
  int? pickupAddressId;
  int? deliveryAddressId;
  String? currentStatus;
  String? pickupPhone;
  String? deliveryPhone;
  int? orderAmount;
  double? orderTax;
  double? orderDiscount;
  String? orderDate;
  String? deliveryAddress;
  double? deliveryLongitude;
  double? deliveryLatitude;
  String? pickupAddress;
  double? pickupLongitude;
  double? pickupLatitude;
  int? pickupPhoneno;
  String? driverName;
  String? customerName;
  String? paymentType;
  String? driverMobile;
  List<Note>? notes;
  List<ProductItem>? productItems;

  GetAssignedDetails({
    this.orderId,
    this.driverId,
    this.customerId,
    this.pickupAddressId,
    this.deliveryAddressId,
    this.currentStatus,
    this.pickupPhone,
    this.deliveryPhone,
    this.orderAmount,
    this.orderTax,
    this.orderDiscount,
    this.orderDate,
    this.deliveryAddress,
    this.deliveryLongitude,
    this.deliveryLatitude,
    this.pickupAddress,
    this.pickupLongitude,
    this.pickupLatitude,
    this.pickupPhoneno,
    this.driverName,
    this.customerName,
    this.paymentType,
    this.driverMobile,
    this.notes,
    this.productItems,
  });

  factory GetAssignedDetails.fromJson(Map<String, dynamic> json) => GetAssignedDetails(
    orderId: json["OrderId"],
    driverId: json["driverId"],
    customerId: json["customerId"],
    pickupAddressId: json["pickupAddressId"],
    deliveryAddressId: json["deliveryAddressId"],
    currentStatus: json["currentStatus"],
    pickupPhone: json["pickupPhone"],
    deliveryPhone: json["deliveryPhone"],
    orderAmount: json["orderAmount"],
    orderTax: json["orderTax"],
    orderDiscount: json["orderDiscount"],
    orderDate: json["orderDate"],
    deliveryAddress: json["deliveryAddress"],
    deliveryLongitude: json["deliveryLongitude"] ?? 0.0,
    deliveryLatitude: json["deliveryLatitude"] ?? 0.0,
    pickupAddress: json["pickupAddress"],
    pickupLongitude: json["pickupLongitude"] ?? 0.0,
    pickupLatitude: json["pickupLatitude"] ?? 0.0,
    pickupPhoneno: json["pickupPhoneno"],
    driverName: json["driverName"],
    customerName: json["customerName"],
    paymentType: json["paymentType"],
    driverMobile: json["driverMobile"],
    notes: json["notes"] == null ? [] : List<Note>.from(json["notes"]!.map((x) => Note.fromJson(x))),
    productItems: json["productItems"] == null ? [] : List<ProductItem>.from(json["productItems"]!.map((x) => ProductItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "OrderId": orderId,
    "driverId": driverId,
    "customerId": customerId,
    "pickupAddressId": pickupAddressId,
    "deliveryAddressId": deliveryAddressId,
    "currentStatus": currentStatus,
    "pickupPhone": pickupPhone,
    "deliveryPhone": deliveryPhone,
    "orderAmount": orderAmount,
    "orderTax": orderTax,
    "orderDiscount": orderDiscount,
    "orderDate": orderDate,
    "deliveryAddress": deliveryAddress,
    "deliveryLongitude": deliveryLongitude,
    "deliveryLatitude": deliveryLatitude,
    "pickupAddress": pickupAddress,
    "pickupLongitude": pickupLongitude,
    "pickupLatitude": pickupLatitude,
    "pickupPhoneno": pickupPhoneno,
    "driverName": driverName,
    "customerName": customerName,
    "paymentType": paymentType,
    "driverMobile": driverMobile,
    "notes": notes == null ? [] : List<dynamic>.from(notes!.map((x) => x.toJson())),
    "productItems": productItems == null ? [] : List<dynamic>.from(productItems!.map((x) => x.toJson())),
  };
}

class Note {
  String? orderId;
  String? action;
  DateTime? createdDate;

  Note({
    this.orderId,
    this.action,
    this.createdDate,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    orderId: json["orderId"],
    action: json["action"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "action": action,
    "createdDate": createdDate?.toIso8601String(),
  };
}

class ProductItem {
  String? productId;
  String? productName;
  String? productDesc;
  String? productImage;
  double? productQuantity;
  double? productPrice;

  ProductItem({
    this.productId,
    this.productName,
    this.productDesc,
    this.productImage,
    this.productQuantity,
    this.productPrice,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
    productId: json["productId"],
    productName: json["productName"],
    productDesc: json["productDesc"],
    productImage: json["productImage"],
    productQuantity: json["productQuantity"] ?? 0.0,
    productPrice: json["productPrice"] ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productName": productName,
    "productDesc": productDesc,
    "productImage": productImage,
    "productQuantity": productQuantity,
    "productPrice": productPrice,
  };
}
