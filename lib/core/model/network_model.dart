class NetworkModel {
  bool? success;
  String? message;
  dynamic data;

  NetworkModel({
    this.message,
    this.success,
    this.data,
  });

  NetworkModel.fromJson(Map<String, dynamic> jsonResponse) {
    success = jsonResponse['success'];
    message = jsonResponse['message'];
    if (jsonResponse['data'] != null) data = jsonResponse['data'];
  }
}
