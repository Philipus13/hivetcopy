import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class SessionInitialState extends SessionState {}

class SessionLoggedinUserState extends SessionState {}

class SessionLoggedInDoctorState extends SessionState {}

class SessionLoggedInStoreState extends SessionState {}

class SessionNoToken extends SessionState {}

class SessionFailure extends SessionState {}

class SessionLogout extends SessionState {
  final String message;
  const SessionLogout(this.message);

  @override
  List<Object> get props => [message];
  @override
  String toString() => 'SessionLogout';
}

class SessionInProgress extends SessionState {
  const SessionInProgress();

  @override
  List<Object> get props => [];
  @override
  String toString() => 'SessionInProgress';
}
