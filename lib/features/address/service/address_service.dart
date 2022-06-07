import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/network/base_network.dart';
import 'package:hivet/core/network/network_utils.dart';

import 'package:hivet/features/address/model/post_address_model.dart'
    as postAddressModel;

class AddressService extends BaseNetworks {
  Future<dynamic> getAddress() async {
    return await service.baseNetworks(
      HttpmethodEnum.get,
      CommonConstants.getAddress,
      isToken: true,
    );
  }

  Future<dynamic> postAddress(postAddressModel.Data data) async {
    Map<String, dynamic>? body = data.toJson();
    return await service.baseNetworks(
        HttpmethodEnum.post, CommonConstants.postAdresses,
        isToken: true, body: body);
  }

  Future<dynamic> deleteAddress(String? addressId) async {
    var queryParams = <String, String>{
      'address_id': addressId!,
    };
    return await service.baseNetworks(
        HttpmethodEnum.delete, CommonConstants.deleteAddresses,
        isToken: true, queryParams: queryParams);
  }

  Future<dynamic> activatingAdress(String? addressId) async {
    var queryParams = <String, String>{
      'address_id': addressId!,
    };
    return await service.baseNetworks(
        HttpmethodEnum.get, CommonConstants.activatingAddress,
        isToken: true, queryParams: queryParams);
  }

  Future<dynamic> patchAddress(postAddressModel.Data data) async {
    Map<String, dynamic>? body = data.toJson();
    var queryParams = <String, dynamic>{
      'addr_id': data.id!,
    };
    return await service.baseNetworks(
        HttpmethodEnum.patch, CommonConstants.patchAdresses,
        isToken: true, queryParams: queryParams, body: body);
  }
}
