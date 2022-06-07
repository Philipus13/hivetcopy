import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/network/base_network.dart';
import 'package:hivet/core/network/network_utils.dart';

class ReservationService extends BaseNetworks {
  Future<dynamic> getMaster(String modelId) async {
    var queryParams = <String, String>{
      'model_id': modelId,
    };
    return await service.baseNetworks(
        HttpmethodEnum.get, CommonConstants.getMasterUser,
        queryParams: queryParams, isToken: false);
  }

  Future<dynamic> getListSlot(
      {String? typeSlot,
      String? specialization,
      String? day,
      String? skip,
      String? limit}) async {
    var queryParams = <String, dynamic>{
      'type_slot': typeSlot,
      'skip': skip!,
      'limit': limit,
    };
    if (specialization != null) {
      queryParams = <String, dynamic>{
        'type_slot': typeSlot,
        'specialization': specialization,
        'skip': skip,
        'limit': limit,
      };
    }
    if (day != null) {
      queryParams = <String, dynamic>{
        'type_slot': typeSlot,
        'day': day,
        'skip': skip,
        'limit': limit,
      };
    }
    if (specialization != null && day != null) {
      queryParams = <String, dynamic>{
        'type_slot': typeSlot,
        'specialization': specialization,
        'day': day,
        'skip': skip,
        'limit': limit,
      };
    }

    return await service.baseNetworks(
        HttpmethodEnum.get, CommonConstants.slotUser,
        isToken: false, queryParams: queryParams);
  }
}
