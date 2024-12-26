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
  String? logType;

  OtpModel({
    this.userId,
    this.logType,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        userId: json["UserId"],
        logType: json["LogType"],
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "LogType": logType,
      };
}
