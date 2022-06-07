import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/model/master_model.dart' as masterModel;
import 'package:hivet/features/reservation/model/slot_model.dart' as slotModel;

import 'package:hivet/features/reservation/service/reservation_service.dart';
import 'package:hivet/features/reservation_detail/model/list_schedule_time_model.dart';

part 'reservation_detail_event.dart';
part 'reservation_detail_state.dart';

class ReservationDetailBloc
    extends Bloc<ReservationDetailEvent, ReservationDetailState> {
  final reservationService = g<ReservationService>();

  ReservationDetailBloc() : super(ReservationDetailState.initialData()) {
    on<ReservationDetailInitEvent>(_initReservationDetail);
    on<GoBackEvent>(_goBack);
  }

  void _goBack(
    GoBackEvent event,
    Emitter<ReservationDetailState> emit,
  ) async {
    emit(state.delete());
  }

  void _initReservationDetail(
    ReservationDetailInitEvent event,
    Emitter<ReservationDetailState> emit,
  ) async {
    emit(state.update(
      isLoading: true,
      isSuccess: false,
      isError: false,
    ));

    List<ListScheduleTimeModel> listScheduleTime = [];
    String? dateScheduleStart;
    String? dateScheduleStartSend;
    String? dateScheduleEnd;
    int? duration;
    DateTime? startDate;
    DateTime? endDate;
    ListScheduleTimeModel? listScheduleTimeModel;

    for (var i = 0; i < event.slotData!.slot!.slot!.length; i++) {
      if (i == 0) {
        dateScheduleStartSend = event.slotData?.slot?.slot?[i].start;
      }
      dateScheduleStart = event.slotData?.slot?.slot?[i].start;
      dateScheduleEnd = event.slotData?.slot?.slot?[i].end;

      String? durasi = event.slotData?.slot?.slot?[i].durasi;
      duration = int.parse(durasi!);

      String fulldateStart = '2019-11-20 ' + dateScheduleStart! + ':00';
      String fulldateEnd = '2019-11-20 ' + dateScheduleEnd! + ':00';
      startDate = DateTime.parse(fulldateStart);
      endDate = DateTime.parse(fulldateEnd);
      for (int j = 0;
          j < endDate.difference(startDate).inMinutes;
          j = j + duration) {
        DateTime startPlusDuration =
            startDate.add(Duration(minutes: j)).toLocal();
        String time = getTimeSpace(startPlusDuration.toString());
        listScheduleTimeModel = ListScheduleTimeModel(time, true);
        //add model to list
        listScheduleTime.add(listScheduleTimeModel);
      }
    }

    try {
      final getMasterFee = await reservationService
          .getMaster("service_fee")
          .then((value) => masterModel.masterModelFromJson(json.encode(value)));
      final getMasterPet = await reservationService
          .getMaster("pet")
          .then((value) => masterModel.masterModelFromJson(json.encode(value)));

      if (getMasterFee.success!) {
        emit(state.update(
            isLoading: false,
            isSuccess: true,
            masterListFee: getMasterFee.data,
            masterListPet: getMasterPet.data,
            listScheduleTime: listScheduleTime,
            dateScheduleStart: dateScheduleStartSend,
            dateScheduleEnd: dateScheduleEnd));
      }
    } on RemoteDataSourceException catch (e) {
      emit(state.update(
          isLoading: false,
          isError: true,
          message: e.message,
          dateScheduleStart: dateScheduleStart,
          dateScheduleEnd: dateScheduleEnd,
          listScheduleTime: listScheduleTime));
    } catch (e) {
      emit(state.update(
          isLoading: false,
          isError: true,
          listScheduleTime: listScheduleTime,
          dateScheduleStart: dateScheduleStart,
          dateScheduleEnd: dateScheduleEnd,
          message: allTranslations.text('reservation.master_failed')));
    }
  }

  String getTimeSpace(String dateTime) {
    List<String> listTime = dateTime.split(' ');
    String time = listTime[1];
    String timereturn = time.substring(0, 5);
    return timereturn;
  }
}
