part of 'doctor_slot_bloc.dart';

abstract class DoctorSlotWEvent extends Equatable {
  const DoctorSlotWEvent();

  @override
  List<Object?> get props => [];
}

class GoBackEvent extends DoctorSlotWEvent {}

class DoctorSlotWInitEvent extends DoctorSlotWEvent {}

class AddSlotEvent extends DoctorSlotWEvent {
  final String? day;
  final String? start;
  final String? end;
  final String? duration;

  const AddSlotEvent({this.day, this.start, this.end, this.duration});

  @override
  List<Object?> get props => [day, start, end, duration];
}

class ActivatingEvent extends DoctorSlotWEvent {
  final bool? isActive;

  const ActivatingEvent({this.isActive});

  @override
  List<Object?> get props => [isActive];
}

class AddDayEvent extends DoctorSlotWEvent {
  final String? addDay;

  const AddDayEvent({this.addDay});

  @override
  List<Object?> get props => [addDay];
}

class AddStartEvent extends DoctorSlotWEvent {
  final String? addStart;

  const AddStartEvent({this.addStart});

  @override
  List<Object?> get props => [addStart];
}

class AddEndEvent extends DoctorSlotWEvent {
  final String? addEnd;

  const AddEndEvent({this.addEnd});

  @override
  List<Object?> get props => [addEnd];
}

class DeleteSlotEvent extends DoctorSlotWEvent {
  final int? index;

  const DeleteSlotEvent({
    this.index,
  });

  @override
  List<Object?> get props => [
        index,
      ];
}

class SubmitSlotEvent extends DoctorSlotWEvent {}

// class SubmitSlotEvent extends DoctorSlotWEvent {
//   final bool? isActive;

//   const SubmitSlotEvent({this.isActive});

//   @override
//   List<Object?> get props => [
//         isActive,
//       ];
// }

// class DoctorSlotWInitEvent extends DoctorSlotWEvent {
//   final doctorSlotModel.Data? slotData;

//   const DoctorSlotWInitEvent(this.slotData);

//   @override
//   List<Object?> get props => [slotData];
// }
