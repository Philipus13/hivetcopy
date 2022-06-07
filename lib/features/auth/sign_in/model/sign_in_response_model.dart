// To parse this JSON data, do
//
//     final signInResponseModel = signInResponseModelFromJson(jsonString);

import 'dart:convert';

SignInResponseModel signInResponseModelFromJson(String str) => SignInResponseModel.fromJson(json.decode(str));

String signInResponseModelToJson(SignInResponseModel data) => json.encode(data.toJson());

class SignInResponseModel {
    SignInResponseModel({
        this.tokenType,
        this.accessToken,
        this.expiresIn,
        this.scopes,
    });

    String? tokenType;
    String? accessToken;
    int? expiresIn;
    String? scopes;

    factory SignInResponseModel.fromJson(Map<String, dynamic> json) => SignInResponseModel(
        tokenType: json["token_type"] == null ? null : json["token_type"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
        expiresIn: json["expires_in"] == null ? null : json["expires_in"],
        scopes: json["scopes"] == null ? null : json["scopes"],
    );

    Map<String, dynamic> toJson() => {
        "token_type": tokenType == null ? null : tokenType,
        "access_token": accessToken == null ? null : accessToken,
        "expires_in": expiresIn == null ? null : expiresIn,
        "scopes": scopes == null ? null : scopes,
    };
}
