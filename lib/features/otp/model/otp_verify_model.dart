import 'dart:convert';

OtpVerifyModel otpVerifyModelFromJson(String str) =>
    OtpVerifyModel.fromJson(json.decode(str));

String otpVerifyModelToJson(OtpVerifyModel data) => json.encode(data.toJson());

class OtpVerifyModel {
  bool? success;
  String? message;
  Data? data;

  OtpVerifyModel({this.success, this.message, this.data});

  OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? email;
  String? username;
  String? fullName;
  String? countryCode;
  String? phone;
  bool? verified;
  String? lastLoginAt;
  String? verifiedAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.email,
      this.username,
      this.fullName,
      this.countryCode,
      this.phone,
      this.verified,
      this.lastLoginAt,
      this.verifiedAt,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    fullName = json['full_name'];
    countryCode = json['country_code'];
    phone = json['phone'];
    verified = json['verified'];
    lastLoginAt = json['last_login_at'];
    verifiedAt = json['verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['verified'] = this.verified;
    data['last_login_at'] = this.lastLoginAt;
    data['verified_at'] = this.verifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
