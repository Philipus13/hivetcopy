import 'dart:convert';

OtpCheckVerifyModel otpCheckVerifyModelFromJson(String str) =>
    OtpCheckVerifyModel.fromJson(json.decode(str));

String otpCheckVerifyModelToJson(OtpCheckVerifyModel data) =>
    json.encode(data.toJson());

class OtpCheckVerifyModel {
  bool? success;
  String? message;
  bool? data;

  OtpCheckVerifyModel({this.success, this.message, this.data});

  OtpCheckVerifyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
