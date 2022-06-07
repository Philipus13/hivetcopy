part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccess extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterVerified extends RegisterState {
  final String? countryCode;
  final String? phone;
  final String? scopes;
  RegisterVerified(this.countryCode, this.phone, this.scopes);
  @override
  List<Object?> get props => [this.countryCode, this.phone, this.scopes];
}

class RegisterFailed extends RegisterState {
  final String? errorMessage;

  RegisterFailed({this.errorMessage});
  @override
  List<Object?> get props => [this.errorMessage];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => [];
}
