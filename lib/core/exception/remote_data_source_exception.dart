import 'dart:io';

class RemoteDataSourceException extends HttpException {
  final int statusCode;

  final List<FieldError>? fieldError;
  final bool? success;

  RemoteDataSourceException(
      this.statusCode, String message, this.fieldError, this.success)
      : super(message);

  @override
  String toString() =>
      'RemoteDataSourceException{statusCode=$statusCode, message=$message}';
}

class FieldError {
  String? field;
  String? message;

  FieldError({
    this.field,
    this.message,
  });

  factory FieldError.fromJson(Map<String, dynamic> json) => FieldError(
        field: json["field"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "field": field,
        "message": message,
      };
}
