import 'package:hivet/core/config/flavor.dart';
import 'package:hivet/core/exception/unexpected_error_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';

import '../local/user_secure_storage.dart';
import 'network_utils.dart';

abstract class BaseNetworks {
  final BaseNetwork _service = BaseNetwork();

  BaseNetwork get service => _service;
}

class BaseNetwork {
  final instance = g<FlavorConfigs>();

  // final String baseUrl = FlavorConfig.instance!.values.baseUrl!;

  BaseNetwork();

  Future<Map<String, String>> _getHeaderWithAuth() async {
    final token = await UserSecureStorage.getToken() ?? '';

    var header = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return header;
  }

  Map<String, dynamic> getHeaderNoAuth() {
    var header = {'Content-Type': 'application/json'};
    return header;
  }

  Future<dynamic> getNoToken({
    String? additionalPath,
    Map<String, dynamic>? queryParams,
  }) async {
    String path = additionalPath ?? '';

    try {
      final url = Uri.https(instance.getUrl(), path, queryParams);

      return await NetworkUtils.helperURL(
        HttpmethodEnum.get,
        url,
      ).then((response) => response);
    } catch (err) {
      throw UnexpectedErrorException(errorMessage: 'error');
    }
  }

  Future<dynamic> baseNetworks(
    HttpmethodEnum method,
    String additionalPath, {
    required bool isToken,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  }) async {
    try {
      final url = Uri.https(instance.getUrl(), additionalPath, queryParams);
      if (isToken) {
        return await NetworkUtils.helperURL(method, url,
                headers: await _getHeaderWithAuth(), body: body)
            .then((response) => response);
      } else {
        return await NetworkUtils.helperURL(method, url, body: body)
            .then((response) => response);
      }
    } catch (err) {
      throw err;
    }
  }
}
