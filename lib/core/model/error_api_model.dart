class ErrorAPIModel {
  bool? success;
  String? field;
  String? message;
  int? statusCode;

  ErrorAPIModel({
    this.success,
    this.field,
    this.message,
    this.statusCode,
  });

  factory ErrorAPIModel.fromJson(Map<dynamic, dynamic> json) => ErrorAPIModel(
        success: json["success"],
        field: json["field"],
        message: json["message"],
        statusCode: json["statusCode"],
      );

  Map<dynamic, dynamic> toJson() => {
        "success": success,
        "field": field,
        "message": message,
        "statusCode": statusCode,
      };
}
