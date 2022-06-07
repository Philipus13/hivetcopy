part of 'reservation_detail_bloc.dart';

abstract class ReservationDetailEvent extends Equatable {
  const ReservationDetailEvent();

  @override
  List<Object?> get props => [];
}

class GoBackEvent extends ReservationDetailEvent {}

class ReservationDetailInitEvent extends ReservationDetailEvent {
  final slotModel.Data? slotData;

  const ReservationDetailInitEvent(this.slotData);

  @override
  List<Object?> get props => [slotData];
}

class ChooseSlotEvent extends ReservationDetailEvent {
  final String? slotChoosen;

  const ChooseSlotEvent(this.slotChoosen);

  @override
  List<Object?> get props => [slotChoosen];
}
