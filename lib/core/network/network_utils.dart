import 'dart:convert';
import 'dart:io';

import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

enum HttpmethodEnum { get, post, put, patch, delete }

// enum Role { superAdmin, adminDokter, adminToko, adminPengguna, adminTransaksi, toko, pengguna, dokterHewan }

class NetworkUtils {
  /**
   * Method to get file 
   */

  static Future helperURLFile(
    List<MultipartFile> multiPartFileList,
    String method,
    Uri url, {
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    late http.MultipartRequest request;

    //if set in this dont pass null variable, cause it makes unhandled exception
    try {
      request = http.MultipartRequest(method, url)
        ..headers.addAll(headers!)
        ..fields.addAll(body!)
        ..files.addAll(multiPartFileList);
    } catch (e) {
      e.toString();
    }

    final streamedReponse = await request.send();
    final statusCode = streamedReponse.statusCode;
    final decoded = json.decode(await streamedReponse.stream.bytesToString());

    if (statusCode == 401) {}

    if (statusCode < 200 || statusCode >= 300) {
      throw RemoteDataSourceException(statusCode, decoded['message'],
          decoded['field_errors'], decoded['success']);
    }

    return decoded;
  }

  /**
   * Method helper to get request by get post put patch delete
   */

  static Future helperURL(
    HttpmethodEnum method,
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    String? bodys;
    dynamic decoded;
    late http.Response response;
    int statusCode;

    if (body != null) {
      bodys = jsonEncode(body);
    }

    try {
      switch (method) {
        case HttpmethodEnum.get:
          response = await http
              .get(url, headers: headers)
              .timeout(const Duration(seconds: 15));

          break;
        case HttpmethodEnum.post:
          response = await http
              .post(url, body: bodys, headers: headers)
              .timeout(const Duration(seconds: 15));

          break;
        case HttpmethodEnum.put:
          response = await http
              .put(url, body: bodys, headers: headers)
              .timeout(const Duration(seconds: 15));

          break;
        case HttpmethodEnum.patch:
          response = await http
              .patch(url, body: bodys, headers: headers)
              .timeout(const Duration(seconds: 15));
          break;

        case HttpmethodEnum.delete:
          response = await http
              .delete(url, body: bodys, headers: headers)
              .timeout(const Duration(seconds: 15));

          break;
        default:
      }

      statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300) {
        try {
          decoded = json.decode(response.body);
          throw RemoteDataSourceException(statusCode, decoded['message'],
              decoded['field_errors'], decoded['success']);
        } catch (e) {
          if (e is RemoteDataSourceException) {
            throw RemoteDataSourceException(statusCode, decoded['message'],
                decoded['field_errors'], decoded['success']);
          }
          if (e is FormatException) {
            throw RemoteDataSourceException(
                statusCode, 'Invalid error', null, false);
          }
          if (e is SocketException) {
            throw RemoteDataSourceException(statusCode,
                allTranslations.text('timeout_connection'), null, false);
          }
        }
      }
    } catch (e) {
      if (e is RemoteDataSourceException) {
        throw RemoteDataSourceException(
            e.statusCode, e.message, decoded['field_errors'], false);
      }
      if (e is FormatException) {
        throw RemoteDataSourceException(400, 'Invalid error', null, false);
      }
      if (e is SocketException) {
        throw RemoteDataSourceException(
            408, allTranslations.text('timeout_connection'), null, false);
      }
    }

    decoded = json.decode(response.body);

    return decoded;
  }

  /**
   * Method static to get helper 
   */

  // static Future post(
  //   Uri url, {
  //   Map<String, String>? headers,
  //   Map<String, String?>? body,
  // }) =>
  //     _helper(
  //       'POST',
  //       url,
  //       headers: headers,
  //       body: body,
  //     );

  // static Future put(
  //   Uri url, {
  //   Map<String, String>? headers,
  //   body,
  // }) =>
  //     _helper(
  //       'PUT',
  //       url,
  //       headers: headers,
  //       body: body,
  //     );

}
