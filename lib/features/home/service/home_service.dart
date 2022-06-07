import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/network/base_network.dart';
import 'package:hivet/core/network/network_utils.dart';

class HomeService extends BaseNetworks {
  Future<dynamic> getMasterShopCategory() async {
    var queryParams = <String, String>{
      'model_id': "shop_category",
    };
    return await service.baseNetworks(
        HttpmethodEnum.get, CommonConstants.getMasterUser,
        queryParams: queryParams, isToken: false);
  }
}
