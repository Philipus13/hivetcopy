import 'dart:convert';

DoctorSlotModel doctorSlotModelFromJson(String str) =>
    DoctorSlotModel.fromJson(json.decode(str));
String doctorSlotModelToJson(DoctorSlotModel data) =>
    json.encode(data.toJson());

class DoctorSlotModel {
  bool? success;
  String? message;
  List<Data>? data;

  DoctorSlotModel({this.success, this.message, this.data});

  DoctorSlotModel.fromJson(Map<String, dynamic> json) {
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
  String? updatedAt;
  String? createdAt;
  List<Slot>? slot;
  String? dokterId;
  String? id;
  bool? isActive;
  String? typeSlot;

  Data(
      {this.updatedAt,
      this.createdAt,
      this.slot,
      this.dokterId,
      this.id,
      this.isActive,
      this.typeSlot});

  Data.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    if (json['slot'] != null) {
      slot = <Slot>[];
      json['slot'].forEach((v) {
        slot!.add(new Slot.fromJson(v));
      });
    }
    dokterId = json['dokter_id'];
    id = json['id'];
    isActive = json['is_active'];
    typeSlot = json['type_slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.slot != null) {
      data['slot'] = this.slot!.map((v) => v.toJson()).toList();
    }
    data['dokter_id'] = this.dokterId;
    data['id'] = this.id;
    data['is_active'] = this.isActive;
    data['type_slot'] = this.typeSlot;
    return data;
  }
}

class Slot {
  String? hari;
  String? start;
  String? end;
  String? durasi;
  String? maxSlot;

  Slot({this.hari, this.start, this.end, this.durasi, this.maxSlot});

  Slot.fromJson(Map<String, dynamic> json) {
    hari = json["hari"] == null ? null : json["hari"];
    start = json["start"] == null ? null : json["start"];
    end = json["end"] == null ? null : json["end"];
    durasi = json["durasi"] == null ? null : json["durasi"];
    maxSlot = json["max_slot"] == null ? null : json["max_slot"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hari != null) {
      data['hari'] = this.hari;
    }
    if (this.start != null) {
      data['start'] = this.start;
    }
    if (this.end != null) {
      data['end'] = this.end;
    }
    if (this.durasi != null) {
      data['durasi'] = this.durasi;
    }
    if (this.maxSlot != null) {
      data['max_slot'] = this.maxSlot;
    }
    return data;
  }
}
