part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

class OtpInitEvent extends OtpEvent {
  final String phoneNum;
  final String countryCode;

  const OtpInitEvent(this.phoneNum, this.countryCode);

  @override
  List<Object?> get props => [phoneNum, countryCode];
}

class OtpResetCodeEvent extends OtpEvent {
  final String phoneNum;
  final String countryCode;

  final int forceResendingToken;

  const OtpResetCodeEvent(
    this.phoneNum,
    this.countryCode,
    this.forceResendingToken,
  );

  @override
  List<Object?> get props => [phoneNum, countryCode, forceResendingToken];
}

class OTPCodeSentEvent extends OtpEvent {
  final String verificationId;
  final int? forceResent;

  const OTPCodeSentEvent(this.verificationId, this.forceResent);

  @override
  List<Object?> get props => [verificationId, forceResent];
}

class OtpPhoneVerificationFailed extends OtpEvent {
  final String? message;

  const OtpPhoneVerificationFailed(
    this.message,
  );

  @override
  List<Object?> get props => [
        message,
      ];
}

class OtpSubmitEvent extends OtpEvent {
  final String verificationId;
  final String otpCode;
  final String countryCode;
  final String phone;

  const OtpSubmitEvent(
      this.verificationId, this.otpCode, this.countryCode, this.phone);

  @override
  List<Object?> get props => [verificationId, otpCode, countryCode, phone];
}
