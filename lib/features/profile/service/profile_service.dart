import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/network/base_network.dart';
import 'package:hivet/core/network/network_utils.dart';
import 'package:hivet/features/profile/model/profile_model.dart'
    as profileModel;

class ProfileService extends BaseNetworks {
  Future<dynamic> getProfile() async {
    return await service.baseNetworks(
        HttpmethodEnum.get, CommonConstants.getUserProfiles,
        isToken: true);
  }

  Future<dynamic> postUserProfile(profileModel.Data? profileBody) async {
    return await service.baseNetworks(
        HttpmethodEnum.post, CommonConstants.postUserProfile,
        body: profileBody?.toJson(), isToken: true);
  }

  Future<dynamic> changePassword(String oldPassword, String newPassword) async {
    var body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
    return await service.baseNetworks(
        HttpmethodEnum.post, CommonConstants.changePassword,
        body: body, isToken: true);
  }

  Future<dynamic> checkVerify() async {
    return await service.baseNetworks(
      HttpmethodEnum.get,
      CommonConstants.checkVerify,
      isToken: true,
    );
  }
}
