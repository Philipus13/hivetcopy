import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/config/helper.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/model/master_model.dart' as masterModel;
import 'package:hivet/features/reservation/model/slot_model.dart' as slotModel;
import 'package:hivet/features/reservation/service/reservation_service.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final reservationService = g<ReservationService>();
  List<masterModel.Data>? mModelSpecialization;

  int page = 0;
  bool hasReachedMax = false;

  ReservationBloc() : super(ReservationState.initialData()) {
    on<ReservationInitEvent>(_initReservation);
    on<GoBackEvent>(_goBack);
    on<LoadListEvent>(_loadList);
    on<ScrollListEvent>(_scrollList);
  }

  void _initReservation(
    ReservationInitEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(state.update(
        isLoading: true, isSuccess: false, isError: false, isFrom: null));

    try {
      final getMasterSpecialization = await reservationService
          .getMaster("specialization")
          .then((value) => masterModel.masterModelFromJson(json.encode(value)));

      if (getMasterSpecialization.success!) {
        mModelSpecialization = getMasterSpecialization.data;

        Iterable<masterModel.Data> insertItem = [
          // masterModel.Data(
          //   isActive: true,
          //   modelId: null,
          //   updatedAt: null,
          //   createdAt: null,
          //   modelName: 'Filter',
          //   id: '1',
          //   updatedBy: null,
          //   createdBy: null,
          // ),
          masterModel.Data(
            isActive: true,
            modelId: null,
            updatedAt: null,
            createdAt: null,
            modelName: 'Semua',
            id: '1',
            updatedBy: null,
            createdBy: null,
          )
        ];
        mModelSpecialization?.insertAll(0, insertItem);
        emit(state.update(
          isLoading: false,
          isSuccess: true,
          isFrom: isFromReservation.master,
          masterListSpecialization: mModelSpecialization,
        ));
      }
    } on RemoteDataSourceException catch (e) {
      emit(state.update(
          isLoading: false,
          isError: true,
          isFrom: isFromReservation.master,
          message: e.message));
    } catch (e) {
      emit(state.update(
          isLoading: false,
          isError: true,
          isFrom: isFromReservation.master,
          message: allTranslations.text('reservation.master_failed')));
    }

    await _getList(emit, null, Helper.convertToDay(DateTime.now()), 0, 5);
  }

  void _goBack(
    GoBackEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(state.delete());
    hasReachedMax = false;
    page = 0;
  }

  void _scrollList(
    ScrollListEvent event,
    Emitter<ReservationState> emit,
  ) async {
    int page = event.skip! + 1;
    emit(state.update(
      isLoading: true,
      isSuccess: false,
      isError: false,
      isFrom: null,
    ));

    await _getScrollList(
        emit, event.specialization, event.day, page, event.limit);
  }

  _getScrollList(
    Emitter<ReservationState> emit,
    String? specialization,
    String? day,
    int? skip,
    int? limit,
  ) async {
    try {
      final getSlot = await reservationService
          .getListSlot(
              typeSlot: 'weekly',
              specialization: specialization,
              day: day,
              skip: skip.toString(),
              limit: limit.toString())
          .then((value) => slotModel.slotModelFromJson(json.encode(value)));

      if (getSlot.success!) {
        if (getSlot.data!.isEmpty) {
          hasReachedMax = true;

          emit(state.update(
            // hasReachedMax: true,
            isSuccess: true,
            isFrom: isFromReservation.slot,
          ));
          ;
        } else {
          page++;
          emit(state.update(
              isLoading: false,
              isSuccess: true,
              isFrom: isFromReservation.slot,
              // page: skip,
              slotList: this.state.slotList! + getSlot.data!));
        }
      }
    } on RemoteDataSourceException catch (e) {
      emit(state.update(
          isLoading: false,
          isError: true,
          isFrom: isFromReservation.slot,
          message: e.message));
    } catch (e) {
      emit(state.update(
          isLoading: false,
          isError: true,
          isFrom: isFromReservation.slot,
          message: allTranslations.text('reservation.error_failed')));
    }
  }

  void _loadList(
    LoadListEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(state.update(
        isLoading: true, isSuccess: false, isError: false, isFrom: null));
    await _getList(
        emit, event.specialization, event.day, event.skip, event.limit);
  }

  _getList(
    Emitter<ReservationState> emit,
    String? specialization,
    String? day,
    int? skip,
    int? limit,
  ) async {
    try {
      final getSlot = await reservationService
          .getListSlot(
              typeSlot: 'weekly',
              specialization: specialization,
              day: day,
              skip: skip.toString(),
              limit: limit.toString())
          .then((value) => slotModel.slotModelFromJson(json.encode(value)));

      if (getSlot.success!) {
        hasReachedMax = false;
        page = 0;
        emit(state.update(
            isLoading: false,
            isSuccess: true,
            isFrom: isFromReservation.slot,
            slotList: getSlot.data));
      }
    } on RemoteDataSourceException catch (e) {
      emit(state.update(
          isLoading: false,
          isError: true,
          isFrom: isFromReservation.slot,
          message: e.message));
    } catch (e) {
      emit(state.update(
          isLoading: false,
          isError: true,
          isFrom: isFromReservation.slot,
          message: allTranslations.text('reservation.error_failed')));
    }
  }
}
