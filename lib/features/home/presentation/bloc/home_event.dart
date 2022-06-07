part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeInitEvent extends HomeEvent {
  final String? scopes;

  const HomeInitEvent(this.scopes);

  @override
  List<Object?> get props => [scopes];
}
