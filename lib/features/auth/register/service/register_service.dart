import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/network/base_network.dart';
import 'package:hivet/core/network/network_utils.dart';

class RegisterService extends BaseNetworks {
  Future<dynamic> registerAccount(Map<String, String?> data) async {
    return await service.baseNetworks(
        HttpmethodEnum.post, CommonConstants.registerUser,
        isToken: false, body: data);
  }
}
