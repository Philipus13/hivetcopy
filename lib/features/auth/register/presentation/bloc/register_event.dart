part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUserEvent extends RegisterEvent {
  final String? username;
  final String? password;
  final String? email;
  final String? fullName;
  final String? countryCode;
  final String? phone;

  RegisterUserEvent({
    this.username,
    this.password,
    this.email,
    this.fullName,
    this.countryCode,
    this.phone,
  });

  @override
  List<Object?> get props => [
        this.username,
        this.password,
        this.email,
        this.fullName,
        this.countryCode,
        this.phone,
      ];
}

class RegisterSuccessEvent extends RegisterEvent {
  final String? username;
  final String? password;

  final String? countryCode;
  final String? phone;

  RegisterSuccessEvent({
    this.username,
    this.password,
    this.countryCode,
    this.phone,
  });

  @override
  List<Object?> get props => [
        this.username,
        this.password,
        this.countryCode,
        this.phone,
      ];
}
