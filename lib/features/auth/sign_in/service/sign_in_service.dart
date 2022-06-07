import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/network/base_network.dart';
import 'package:hivet/core/network/network_utils.dart';

class SignInService extends BaseNetworks {
  Future<dynamic> signInAccount({String? username, String? password}) async {
    var body = {
      "grant_type": "password",
      "username": username,
      "password": password
    };
    return await service.baseNetworks(
        HttpmethodEnum.post, CommonConstants.loginUser,
        isToken: false, body: body);
  }
}
