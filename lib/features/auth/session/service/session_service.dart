import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/local/user_secure_storage.dart';
import 'package:hivet/core/network/base_network.dart';
import 'package:hivet/core/network/network_utils.dart';

class SessionService extends BaseNetworks {
  Future<bool> checkToken() async {
    final token = await UserSecureStorage.getToken() ?? "";

    if (token == "") {
      return false;
    } else {
      final splitted = token.split(' ');
      String tokenSplit = splitted[1];
      try {
        var queryParameters = <String, String>{
          'token': tokenSplit,
        };
        await service.baseNetworks(
            HttpmethodEnum.get, CommonConstants.checkToken,
            isToken: false, queryParams: queryParameters);
        return true;
        // } on RemoteDataSourceException catch (e) {
      } on RemoteDataSourceException {
        return false;
      }
    }
  }

  Future<bool> deleteToken() async {
    try {
      await UserSecureStorage.deleteToken();
      return true;
    } catch (e) {
      return false;
    }
  }
}
