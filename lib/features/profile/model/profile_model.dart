import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool? success;
  String? message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});
  ProfileModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      ProfileModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  Doctor? doctor;
  Store? store;
  Address? address;
  String? scopes;

  Data({this.user, this.doctor, this.store, this.address, this.scopes});

  Data copyWith({
    User? user,
    Doctor? doctor,
    Store? store,
    Address? address,
  }) =>
      Data(
        user: user ?? this.user,
        doctor: doctor ?? this.doctor,
        store: store ?? this.store,
        address: address ?? this.address,
      );

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class User {
  String? fullName;
  String? email;
  String? nik;
  String? dob;
  String? gender;
  String? countryCode;
  String? phone;

  User(
      {this.fullName,
      this.email,
      this.nik,
      this.dob,
      this.gender,
      this.countryCode,
      this.phone});

  User copyWith(
          {String? fullName,
          String? email,
          String? nik,
          String? dob,
          String? gender,
          String? countryCode,
          String? phone}) =>
      User(
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        nik: nik ?? this.nik,
        dob: dob ?? this.dob,
        gender: gender ?? this.gender,
        countryCode: countryCode ?? this.countryCode,
        phone: phone ?? this.phone,
      );

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    nik = json['nik'];
    dob = json['dob'];
    gender = json['gender'];
    countryCode = json['country_code'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['nik'] = this.nik;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['countryCode'] = this.countryCode;
    data['phone'] = this.phone;
    return data;
  }
}

class Doctor {
  String? experience;
  String? specialization;
  String? description;
  String? fee;
  String? nip;
  String? duration;

  Doctor(
      {this.experience,
      this.specialization,
      this.description,
      this.fee,
      this.nip,
      this.duration});

  Doctor copyWith({
    String? experience,
    String? specialization,
    String? description,
    String? fee,
    String? nip,
    String? duration,
  }) =>
      Doctor(
        experience: experience ?? this.experience,
        specialization: specialization ?? this.specialization,
        description: description ?? this.description,
        fee: fee ?? this.fee,
        nip: nip ?? this.nip,
        duration: duration ?? this.duration,
      );

  Doctor.fromJson(Map<String, dynamic> json) {
    experience = json['experience'];
    specialization = json['specialization'];
    description = json['description'];
    fee = json['fee'];
    nip = json['nip'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['experience'] = this.experience;
    data['specialization'] = this.specialization;
    data['description'] = this.description;
    data['fee'] = this.fee;
    data['nip'] = this.nip;
    data['duration'] = this.duration;
    return data;
  }
}

class Store {
  String? domain;
  String? slogan;
  String? description;
  String? since;

  Store({this.domain, this.slogan, this.description, this.since});

  Store copyWith({
    String? domain,
    String? slogan,
    String? description,
    String? since,
  }) =>
      Store(
        domain: domain ?? this.domain,
        slogan: slogan ?? this.slogan,
        description: description ?? this.description,
        since: since ?? this.since,
      );

  Store.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    slogan = json['slogan'];
    description = json['description'];
    since = json['since'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['slogan'] = this.slogan;
    data['description'] = this.description;
    data['since'] = this.since;
    return data;
  }
}

class Address {
  String? countryCode;
  String? phone;
  String? address;

  Address({this.countryCode, this.phone, this.address});

  Address copyWith({
    String? countryCode,
    String? phone,
    String? address,
  }) =>
      Address(
        countryCode: countryCode ?? this.countryCode,
        phone: phone ?? this.phone,
        address: address ?? this.address,
      );

  Address.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
