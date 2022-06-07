import 'dart:convert';

SlotModel slotModelFromJson(String str) => SlotModel.fromJson(json.decode(str));

String slotModelToJson(SlotModel data) => json.encode(data.toJson());

class SlotModel {
  bool? success;
  String? message;
  List<Data>? data;

  SlotModel({this.success, this.message, this.data});

  SlotModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? fullName;
  String? specialization;
  String? experience;
  String? descritpion;
  String? fee;
  String? nip;
  String? duration;
  Slot? slot;

  Data(
      {this.userId,
      this.fullName,
      this.specialization,
      this.experience,
      this.descritpion,
      this.fee,
      this.nip,
      this.duration,
      this.slot});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    specialization = json['specialization'];
    experience = json['experience'];
    descritpion = json['descritpion'];
    fee = json['fee'];
    nip = json['nip'];
    duration = json['duration'];
    slot = json['slot'] != null ? new Slot.fromJson(json['slot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['specialization'] = this.specialization;
    data['experience'] = this.experience;
    data['descritpion'] = this.descritpion;
    data['fee'] = this.fee;
    data['nip'] = this.nip;
    data['duration'] = this.duration;
    if (this.slot != null) {
      data['slot'] = this.slot!.toJson();
    }
    return data;
  }
}

class Slot {
  String? dokterId;
  String? typeSlot;
  List<SlotDetail>? slot;
  bool? isActive;

  Slot({this.dokterId, this.typeSlot, this.slot, this.isActive});

  Slot.fromJson(Map<String, dynamic> json) {
    dokterId = json['dokter_id'];
    typeSlot = json['type_slot'];
    if (json['slot'] != null) {
      slot = <SlotDetail>[];
      json['slot'].forEach((v) {
        slot!.add(new SlotDetail.fromJson(v));
      });
    }
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dokter_id'] = this.dokterId;
    data['type_slot'] = this.typeSlot;
    if (this.slot != null) {
      data['slot'] = this.slot!.map((v) => v.toJson()).toList();
    }
    data['is_active'] = this.isActive;
    return data;
  }
}

class SlotDetail {
  String? hari;
  String? start;
  String? end;
  String? durasi;
  String? maxSlot;

  SlotDetail({this.hari, this.start, this.end, this.durasi, this.maxSlot});

  SlotDetail.fromJson(Map<String, dynamic> json) {
    hari = json['hari'];
    start = json['start'];
    end = json['end'];
    durasi = json['durasi'];
    maxSlot = json['max_slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hari'] = this.hari;
    data['start'] = this.start;
    data['end'] = this.end;
    data['durasi'] = this.durasi;
    data['max_slot'] = this.maxSlot;
    return data;
  }
}
