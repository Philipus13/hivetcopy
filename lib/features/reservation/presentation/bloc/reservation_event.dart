part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object?> get props => [];
}

class ReservationInitEvent extends ReservationEvent {}

class GoBackEvent extends ReservationEvent {}

class LoadListEvent extends ReservationEvent {
  final String? specialization;
  final String? day;
  final int? skip;
  final int? limit;

  const LoadListEvent({this.specialization, this.day, this.skip, this.limit});

  @override
  List<Object?> get props => [];
}

class ScrollListEvent extends ReservationEvent {
  final String? specialization;
  final String? day;
  final int? skip;
  final int? limit;

  const ScrollListEvent({this.specialization, this.day, this.skip, this.limit});

  @override
  List<Object?> get props => [];
}
