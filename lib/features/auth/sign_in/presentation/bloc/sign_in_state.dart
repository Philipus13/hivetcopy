part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInSuccess extends SignInState {
  final SignInResponseModel? signInResponseModel;

  SignInSuccess({this.signInResponseModel});
  @override
  List<Object?> get props => [this.signInResponseModel];
}

class SignInError extends SignInState {
  final String? errMessage;

  SignInError({this.errMessage});

  @override
  List<Object?> get props => [this.errMessage];
}

class SaveTokenSuccess extends SignInState {
  final String? scopes;

  SaveTokenSuccess({this.scopes});

  @override
  List<Object?> get props => [this.scopes];
}

class SaveTokenError extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInLoading extends SignInState {
  @override
  List<Object> get props => [];
}
