part of 'reservation_detail_bloc.dart';

class ReservationDetailState extends Equatable {
  final List<masterModel.Data>? masterListFee;
  final List<masterModel.Data>? masterListPet;
  final List<ListScheduleTimeModel>? listScheduleTime;
  final bool isLoading;
  final String? message;
  final bool isError;
  final bool isSuccess;
  final String? dateScheduleStart;
  final String? dateScheduleEnd;

  const ReservationDetailState({
    this.masterListFee,
    this.masterListPet,
    this.listScheduleTime,
    this.isLoading = false,
    this.message,
    this.isError = false,
    this.isSuccess = false,
    this.dateScheduleStart,
    this.dateScheduleEnd,
  });

  factory ReservationDetailState.initialData() {
    return ReservationDetailState(
      masterListFee: null,
      masterListPet: null,
      listScheduleTime: null,
      isLoading: false,
      message: null,
      isError: false,
      isSuccess: false,
      dateScheduleStart: null,
      dateScheduleEnd: null,
    );
  }
  ReservationDetailState update({
    List<masterModel.Data>? masterListFee,
    List<masterModel.Data>? masterListPet,
    List<ListScheduleTimeModel>? listScheduleTime,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    String? dateScheduleStart,
    String? dateScheduleEnd,
  }) =>
      ReservationDetailState(
        masterListFee: masterListFee ?? this.masterListFee,
        masterListPet: masterListPet ?? this.masterListPet,
        listScheduleTime: listScheduleTime ?? this.listScheduleTime,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
        dateScheduleStart: dateScheduleStart ?? this.dateScheduleStart,
        dateScheduleEnd: dateScheduleEnd ?? this.dateScheduleEnd,
      );
  ReservationDetailState delete({
    List<masterModel.Data>? masterListFee,
    List<masterModel.Data>? masterListPet,
    List<ListScheduleTimeModel>? listScheduleTime,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    String? dateScheduleStart,
    String? dateScheduleEnd,
  }) =>
      ReservationDetailState(
        masterListFee: null,
        masterListPet: null,
        listScheduleTime: null,
        isLoading: false,
        message: null,
        isError: false,
        isSuccess: false,
        dateScheduleStart: null,
        dateScheduleEnd: null,
      );

  @override
  List<Object?> get props => [
        masterListFee,
        masterListPet,
        listScheduleTime,
        isLoading,
        message,
        isError,
        isSuccess,
        dateScheduleStart,
        dateScheduleEnd
      ];
}
