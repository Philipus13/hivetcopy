import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/network/base_network.dart';
import 'package:hivet/core/network/network_utils.dart';
import 'package:hivet/features/doctor_slot/model/doctor_slot_model.dart'
    as doctorSlotModel;

class DoctorSlotService extends BaseNetworks {
  Future<dynamic> getListSlotDoctor() async {
    return await service.baseNetworks(
      HttpmethodEnum.get,
      CommonConstants.slotDoctor,
      isToken: true,
    );
  }

  Future<dynamic> postSlotWeekly(
      List<doctorSlotModel.Slot>? slot, bool? isActive) async {
    var body = {
      "type_slot": "weekly",
      "slot": slot,
      //  [
      //   {"hari": "senin", "start": "10:15", "end": "10:55", "durasi": "5"},
      //   {"hari": "selasa", "start": "08:00", "end": "12:00", "durasi": "10"},
      //   {"hari": "rabu", "start": "08:30", "end": "09:35", "durasi": "10"},
      //   {"hari": "rabu", "start": "09:50", "end": "12:00", "durasi": "10"},
      //   {"hari": "kamis", "start": "10:30", "end": "12:20", "durasi": "10"},
      //   {"hari": "jumat", "start": "12:30", "end": "15:35", "durasi": "10"}
      // ],
      "is_active": isActive
    };

    return await service.baseNetworks(
        HttpmethodEnum.post, CommonConstants.slotDoctor,
        isToken: true, body: body);
  }
}
