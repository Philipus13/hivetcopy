import 'dart:convert';

PostAddressModel postAddressModelFromJson(String str) =>
    PostAddressModel.fromJson(json.decode(str));

String postAddressModelToJson(PostAddressModel data) =>
    json.encode(data.toJson());

class PostAddressModel {
  bool? success;
  String? message;
  Data? data;

  PostAddressModel({this.success, this.message, this.data});

  PostAddressModel.fromJson(Map<String, dynamic> json) {
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
  String? updatedAt;
  bool? isActive;
  String? address;
  String? countryCode;
  String? type;
  String? id;
  String? createdAt;
  String? postalCode;
  String? phone;
  String? name;
  String? userId;

  Data(
      {this.updatedAt,
      this.isActive,
      this.address,
      this.countryCode,
      this.type,
      this.id,
      this.createdAt,
      this.postalCode,
      this.phone,
      this.name,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    address = json['address'];
    countryCode = json['country_code'];
    type = json['type'];
    id = json['id'];
    createdAt = json['created_at'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    name = json['name'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['address'] = this.address;
    data['country_code'] = this.countryCode;
    data['type'] = this.type;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    return data;
  }
}
