import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/features/doctor_slot/model/doctor_slot_model.dart'
    as doctorSlotModel;
import 'package:hivet/features/profile/model/profile_model.dart'
    as profileModel;
import 'package:hivet/features/doctor_slot/service/doctor_slot_service.dart';
import 'package:hivet/features/profile/service/profile_service.dart';

part 'doctor_slot_event.dart';
part 'doctor_slot_state.dart';

class DoctorSlotWBloc extends Bloc<DoctorSlotWEvent, DoctorSlotWState> {
  final doctorSlotService = g<DoctorSlotService>();
  final profileService = g<ProfileService>();

  DoctorSlotWBloc() : super(DoctorSlotWState.initialData()) {
    on<DoctorSlotWInitEvent>(_initDoctorSlotW);
    on<GoBackEvent>(_goBack);
    on<AddSlotEvent>(_addSlot);
    on<AddDayEvent>(_addDay);
    on<AddStartEvent>(_addStart);
    on<AddEndEvent>(_addEnd);
    on<DeleteSlotEvent>(_deleteSlot);
    on<SubmitSlotEvent>(_submitSlot);
    on<ActivatingEvent>(_activating);
  }

  void _goBack(
    GoBackEvent event,
    Emitter<DoctorSlotWState> emit,
  ) async {
    emit(state.delete());
  }

  void _deleteSlot(
    DeleteSlotEvent event,
    Emitter<DoctorSlotWState> emit,
  ) async {
    emit(state.update(
      isLoading: true,
      isSuccess: false,
      isError: false,
    ));

    this.state.doctorSlotList?.removeAt(event.index!);

    emit(state.update(
      isLoading: false,
      isSuccess: true,
    ));
  }

  void _activating(
    ActivatingEvent event,
    Emitter<DoctorSlotWState> emit,
  ) async {
    emit(state.update(
      isLoading: true,
      isSuccess: false,
      isError: false,
    ));

    emit(state.update(
      isLoading: false,
      isSuccess: true,
      isActivated: event.isActive,
    ));
  }

  void _addEnd(
    AddEndEvent event,
    Emitter<DoctorSlotWState> emit,
  ) async {
    emit(state.update(
      isLoading: true,
      isSuccess: false,
      isError: false,
    ));

    emit(state.update(
      isLoading: false,
      isSuccess: true,
      addEnd: event.addEnd,
    ));
  }

  void _addStart(
    AddStartEvent event,
    Emitter<DoctorSlotWState> emit,
  ) async {
    emit(state.update(
      isLoading: true,
      isSuccess: false,
      isError: false,
    ));

    emit(state.update(
      isLoading: false,
      isSuccess: true,
      addStart: event.addStart,
    ));
  }

  void _addDay(
    AddDayEvent event,
    Emitter<DoctorSlotWState> emit,
  ) async {
    emit(state.update(
      isLoading: true,
      isSuccess: false,
      isError: false,
    ));

    emit(state.update(
      isLoading: false,
      isSuccess: true,
      addDay: event.addDay,
    ));
  }

  void _addSlot(
    AddSlotEvent event,
    Emitter<DoctorSlotWState> emit,
  ) async {
    emit(state.update(
      isLoading: true,
      isSuccess: false,
      isError: false,
    ));

    List<doctorSlotModel.Slot>? doctorSlotList = state.doctorSlotList;

    String fulldateStart = '2019-11-20 ' + event.start! + ':00';
    String fulldateEnd = '2019-11-20 ' + event.end! + ':00';
    DateTime? startDate = DateTime.parse(fulldateStart);
    DateTime? endDate = DateTime.parse(fulldateEnd);
    String day = event.day!;
    bool isSaved = false;
    bool isNew = false;

    int? index;
    String message = '';

    for (var i = 0; i < doctorSlotList!.length; i++) {
      if (doctorSlotList[i].hari == day) {
        String fulldateStartE =
            '2019-11-20 ' + doctorSlotList[i].start! + ':00';
        String fulldateEndE = '2019-11-20 ' + doctorSlotList[i].end! + ':00';
        DateTime? startDateE = DateTime.parse(fulldateStartE);
        DateTime? endDateE = DateTime.parse(fulldateEndE);

        if ((startDateE.isBefore(startDate) && endDateE.isAfter(startDate)) ||
            (startDateE.isBefore(endDate) && endDateE.isAfter(endDate))) {
          // print("dateC is between dateA and dateB");
          isSaved = false;
          message =
              allTranslations.text('slot_doctor.add_slot_fail_between_msg');

          break;
        } else {
          // print("dateC isn't between dateA and dateC");
          if (startDate.isBefore(startDateE)) {
            // print('sebelum, kalo start < start existing cek:');
            if (endDate.isBefore(startDateE)) {
              //print(
              //    'apakah enddate lebih kecil dari startdate existing? krn harus lebih kecil ');
              //print('boleh simpan');
              // check kalo ada double hari biar ngeambil yg ketemu index pertama karena kan sebelum
              isSaved = true;
              if (index == null) {
                index = i;
              }
            } else {
              // print('Tidak bisa simpan');
              // print(
              //   'Case kalo startdate lebih kecil dari startexisting cuma enddate ngelebihin start date bahkan dari enddate existingnya');
              isSaved = false;
              message =
                  allTranslations.text('slot_doctor.add_slot_fail_between_msg');

              break;
            }
          }

          if (startDate.isAfter(endDateE)) {
            isSaved = true;
            index = i + 1;

            // print('boleh simpan');
          }
        }
      }
    }

    for (var j = 0; j < doctorSlotList.length; j++) {
      if (doctorSlotList[j].hari == day) {
        isNew = false;
        break;
      } else {
        isNew = true;
      }
    }

    if (isNew) {
      doctorSlotModel.Slot slot = doctorSlotModel.Slot(
          hari: event.day,
          start: event.start,
          end: event.end,
          durasi: event.duration);

      this.state.doctorSlotList?.add(slot);
      emit(state.update(
        isLoading: false,
        isSuccess: true,
      ));
      return;
    }
    if (isSaved) {
      doctorSlotModel.Slot slot = doctorSlotModel.Slot(
          hari: event.day,
          start: event.start,
          end: event.end,
          durasi: event.duration);

      this.state.doctorSlotList?.insert(index!, slot);
      emit(state.update(
        isLoading: false,
        isSuccess: true,
      ));
    } else {
      emit(state.update(
          isLoading: false,
          isError: true,
          message: message,
          from: From.addSlot));
    }
  }

  void _submitSlot(
    SubmitSlotEvent event,
    Emitter<DoctorSlotWState> emit,
  ) async {
    emit(state.update(
      isLoading: true,
      isSuccess: false,
      isError: false,
    ));

    try {
      final postSlot = await doctorSlotService
          .postSlotWeekly(this.state.doctorSlotList, this.state.isActivated)
          .then(
              (value) => profileModel.profileModelFromJson(json.encode(value)));

      if (postSlot.success!) {
        emit(
            state.update(isLoading: false, isSuccess: true, from: From.submit));
      }
    } on RemoteDataSourceException catch (e) {
      emit(state.update(
        isLoading: false,
        isError: true,
        message: e.message,
      ));
    } catch (e) {
      emit(state.update(
          isLoading: false,
          isError: true,
          message: allTranslations.text('slot_doctor.add_slot_fail_msg')));
    }
  }

  void _initDoctorSlotW(
    DoctorSlotWInitEvent event,
    Emitter<DoctorSlotWState> emit,
  ) async {
    emit(state.update(
      isLoading: true,
      isSuccess: false,
      isError: false,
    ));

    List<doctorSlotModel.Slot>? doctorSlotList = [];
    bool? isActivated;
    try {
      final getProfile = await profileService.getProfile().then(
          (value) => profileModel.profileModelFromJson(json.encode(value)));

      final getDoctorSlot = await doctorSlotService.getListSlotDoctor().then(
          (value) =>
              doctorSlotModel.doctorSlotModelFromJson(json.encode(value)));

      if (getDoctorSlot.success!) {
        for (var i = 0; i < getDoctorSlot.data!.length; i++) {
          if (getDoctorSlot.data![i].typeSlot == CommonConstants.weekly) {
            doctorSlotList = getDoctorSlot.data![i].slot;
            isActivated = getDoctorSlot.data![i].isActive;
          }
        }
      }

      emit(state.update(
          isLoading: false,
          isSuccess: true,
          profileData: getProfile.data,
          doctorSlotList: doctorSlotList,
          isActivated: isActivated));
    } on RemoteDataSourceException catch (e) {
      emit(state.update(
        isLoading: false,
        isError: true,
        message: e.message,
      ));
    } catch (e) {
      emit(state.update(
          isLoading: false,
          isError: true,
          message: allTranslations.text('slot_doctor.load_slot_fail_msg')));
    }
  }
}
