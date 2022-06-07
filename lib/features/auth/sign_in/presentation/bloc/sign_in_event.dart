part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class SignInAccountEvent extends SignInEvent {
  final String? username;
  final String? password;

  SignInAccountEvent({this.username, this.password});

  @override
  List<Object?> get props => [this.username, this.password];
}

class SaveTokenToLocalEvent extends SignInEvent {
  final SignInResponseModel? signInResponseModel;

  SaveTokenToLocalEvent({this.signInResponseModel});

  @override
  List<Object?> get props => [this.signInResponseModel];
}
