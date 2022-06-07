import 'dart:convert';

ForgotCheckVerifyModel forgotCheckVerifyModelFromJson(String str) =>
    ForgotCheckVerifyModel.fromJson(json.decode(str));

String forgotCheckVerifyModelToJson(ForgotCheckVerifyModel data) =>
    json.encode(data.toJson());

class ForgotCheckVerifyModel {
  bool? success;
  String? message;
  String? data;

  ForgotCheckVerifyModel({this.success, this.message, this.data});

  ForgotCheckVerifyModel.fromJson(Map<String, dynamic> json) {
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
