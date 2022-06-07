import 'dart:convert';

MasterModel masterModelFromJson(String str) =>
    MasterModel.fromJson(json.decode(str));

String masterModelToJson(MasterModel data) => json.encode(data.toJson());

class MasterModel {
  bool? success;
  String? message;
  List<Data>? data;

  MasterModel({this.success, this.message, this.data});

  MasterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  bool? isActive;
  String? modelId;
  String? updatedAt;
  String? createdAt;
  String? modelName;
  String? id;
  String? updatedBy;
  String? createdBy;

  Data(
      {this.isActive,
      this.modelId,
      this.updatedAt,
      this.createdAt,
      this.modelName,
      this.id,
      this.updatedBy,
      this.createdBy});

  Data.fromJson(Map<String, dynamic> json) {
    isActive = json['is_active'];
    modelId = json['model_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    modelName = json['model_name'];
    id = json['id'];
    updatedBy = json['updated_by'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_active'] = this.isActive;
    data['model_id'] = this.modelId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['model_name'] = this.modelName;
    data['id'] = this.id;
    data['updated_by'] = this.updatedBy;
    data['created_by'] = this.createdBy;
    return data;
  }
}
