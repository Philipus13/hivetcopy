part of 'reservation_bloc.dart';

// identifier came from what api
enum isFromReservation {
  master,
  slot,
}

class ReservationState extends Equatable {
  final List<masterModel.Data>? masterListSpecialization;

  final List<slotModel.Data>? slotList;
  final bool isLoading;
  final String? message;
  final bool isError;
  final bool isSuccess;
  // final bool hasReachedMax;
  // final int page;
  final isFromReservation? isFrom;

  const ReservationState({
    this.masterListSpecialization,
    this.slotList,
    this.isLoading = false,
    this.message,
    this.isError = false,
    this.isSuccess = false,
    // this.hasReachedMax = false,
    // this.page = 0,
    this.isFrom,
  });

  factory ReservationState.initialData() {
    return ReservationState(
      masterListSpecialization: null,

      slotList: null,
      isLoading: false,
      message: null,
      isError: false,
      isSuccess: false,
      // hasReachedMax: false,
      // page: 0,
      isFrom: null,
    );
  }
  ReservationState update({
    List<masterModel.Data>? masterListSpecialization,
    List<slotModel.Data>? slotList,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    // bool? hasReachedMax,
    // int? page,
    isFromReservation? isFrom,
  }) =>
      ReservationState(
        masterListSpecialization:
            masterListSpecialization ?? this.masterListSpecialization,
        slotList: slotList ?? this.slotList,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
        // hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        // page: page ?? this.page,
        isFrom: isFrom ?? this.isFrom,
      );
  ReservationState delete({
    List<masterModel.Data>? masterListSpecialization,
    List<slotModel.Data>? slotList,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    // bool? hasReachedMax,
    // int? page,
    isFromReservation? isFrom,
  }) =>
      ReservationState(
        masterListSpecialization: null,

        slotList: null,
        isLoading: false,
        message: null,
        isError: false,
        isSuccess: false,
        // hasReachedMax: false,
        // page: 0,
        isFrom: null,
      );

  @override
  List<Object?> get props => [
        masterListSpecialization,

        slotList,
        isLoading,
        message,
        isError,
        isSuccess,
        // hasReachedMax,
        // page,
        isFrom
      ];
}
