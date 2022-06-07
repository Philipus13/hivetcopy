part of 'forgot_bloc.dart';

abstract class ForgotEvent extends Equatable {
  const ForgotEvent();

  @override
  List<Object?> get props => [];
}

class ForgotInitEvent extends ForgotEvent {
  const ForgotInitEvent();

  @override
  List<Object?> get props => [];
}

class ForgotGoToEmailEvent extends ForgotEvent {}

class ForgotGoToPhoneEvent extends ForgotEvent {}

class ForgotDeleteEvent extends ForgotEvent {}

class ForgotVerifyPhoneEvent extends ForgotEvent {
  final String phoneNum;
  final String countryCode;

  const ForgotVerifyPhoneEvent(this.phoneNum, this.countryCode);

  @override
  List<Object?> get props => [phoneNum, countryCode];
}

class ForgotVerifyEmailEvent extends ForgotEvent {
  final String email;

  const ForgotVerifyEmailEvent(this.email);

  @override
  List<Object?> get props => [
        email,
      ];
}

class ForgotResetCodeEvent extends ForgotEvent {
  final String phoneNum;
  final String countryCode;

  final int forceResendingToken;

  const ForgotResetCodeEvent(
    this.phoneNum,
    this.countryCode,
    this.forceResendingToken,
  );

  @override
  List<Object?> get props => [phoneNum, countryCode, forceResendingToken];
}

class ForgotCodeSentEvent extends ForgotEvent {
  final String verificationId;
  final int? forceResent;

  const ForgotCodeSentEvent(this.verificationId, this.forceResent);

  @override
  List<Object?> get props => [verificationId, forceResent];
}

class ForgotVerificationFailed extends ForgotEvent {
  final String? message;

  const ForgotVerificationFailed(
    this.message,
  );

  @override
  List<Object?> get props => [
        message,
      ];
}

class ForgotChangePassEvent extends ForgotEvent {
  final String verificationId;
  final String otpCode;
  final String verificationToken;
  final String? newPass;

  const ForgotChangePassEvent(
      this.verificationId, this.otpCode, this.verificationToken, this.newPass);

  @override
  List<Object?> get props =>
      [verificationId, otpCode, verificationToken, newPass];
}
