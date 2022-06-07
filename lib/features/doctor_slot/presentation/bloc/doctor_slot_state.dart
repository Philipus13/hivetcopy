part of 'doctor_slot_bloc.dart';

enum From { submit, addDay, addSlot, addStart, addEnd, delete }

class DoctorSlotWState extends Equatable {
  final List<doctorSlotModel.Slot>? doctorSlotList;
  final profileModel.Data? profileData;
  final bool isLoading;
  final String? message;
  final bool isError;
  final bool isSuccess;
  final bool isActivated;
  final String? addDay;
  final String? addStart;
  final String? addEnd;
  final From? from;

  const DoctorSlotWState({
    this.doctorSlotList,
    this.profileData,
    this.isLoading = false,
    this.message,
    this.isError = false,
    this.isSuccess = false,
    this.isActivated = false,
    this.addDay,
    this.addStart,
    this.addEnd,
    this.from,
  });

  factory DoctorSlotWState.initialData() {
    return DoctorSlotWState(
      doctorSlotList: null,
      profileData: null,
      isLoading: false,
      message: null,
      isError: false,
      isSuccess: false,
      isActivated: false,
      addDay: null,
      addStart: null,
      addEnd: null,
      from: null,
    );
  }
  DoctorSlotWState update({
    List<doctorSlotModel.Slot>? doctorSlotList,
    profileModel.Data? profileData,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    bool? isActivated,
    String? addDay,
    String? addStart,
    String? addEnd,
    From? from,
  }) =>
      DoctorSlotWState(
        doctorSlotList: doctorSlotList ?? this.doctorSlotList,
        profileData: profileData ?? this.profileData,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
        isActivated: isActivated ?? this.isActivated,
        addDay: addDay ?? this.addDay,
        addStart: addStart ?? this.addStart,
        addEnd: addEnd ?? this.addEnd,
        from: from ?? this.from,
      );
  DoctorSlotWState delete({
    List<doctorSlotModel.Slot>? doctorSlotList,
    profileModel.Data? profileData,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    bool? isActivated,
    String? addDay,
    String? addStart,
    String? addEnd,
    From? from,
  }) =>
      DoctorSlotWState(
        doctorSlotList: null,
        profileData: null,
        isLoading: false,
        message: null,
        isError: false,
        isSuccess: false,
        isActivated: false,
        addDay: null,
        addStart: null,
        addEnd: null,
        from: null,
      );

  @override
  List<Object?> get props => [
        doctorSlotList,
        profileData,
        isLoading,
        message,
        isError,
        isSuccess,
        isActivated,
        addDay,
        addStart,
        addEnd,
        from
      ];
}
