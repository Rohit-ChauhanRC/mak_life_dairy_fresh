// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

List<OtpModel> otpModelFromJson(String str) =>
    List<OtpModel>.from(json.decode(str).map((x) => OtpModel.fromJson(x)));

String otpModelToJson(List<OtpModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OtpModel {
  int? userId;
  int? outletId;
  String? logType;

  OtpModel({
    this.userId,
    this.logType,
    this.outletId,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        userId: json["UserId"],
        logType: json["LogType"],
        outletId: json["OutletId"],
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "LogType": logType,
        "OutletId": outletId,
      };
}
