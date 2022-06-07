import 'package:equatable/equatable.dart';
import 'package:hivet/features/otp/model/otp_verify_model.dart'
    as otpVerifyModel;

class OtpState extends Equatable {
  final otpVerifyModel.Data? data;
  final bool? isLoading;
  final String? message;
  final bool? isError;
  final bool? isSuccess;
  final int? forceResendingToken;
  final String? verificationId;

  const OtpState({
    this.data,
    this.isLoading = false,
    this.message,
    this.isError = false,
    this.isSuccess = false,
    this.forceResendingToken = 0,
    this.verificationId,
  });

  factory OtpState.initialData() {
    return OtpState(
      isLoading: false,
      message: null,
      isError: false,
      isSuccess: false,
      forceResendingToken: 0,
      verificationId: null,
    );
  }
  OtpState update({
    otpVerifyModel.Data? data,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    int? forceResendingToken,
    String? verificationId,
  }) =>
      OtpState(
        data: data ?? this.data,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
        forceResendingToken: forceResendingToken ?? this.forceResendingToken,
        verificationId: verificationId ?? this.verificationId,
      );
  OtpState delete({
    otpVerifyModel.Data? data,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    int? forceResendingToken,
    String? verificationId,
  }) =>
      OtpState(
        data: null,
        isLoading: false,
        message: null,
        isError: false,
        isSuccess: false,
        forceResendingToken: 0,
        verificationId: null,
      );

  @override
  List<Object?> get props => [
        isLoading,
        message,
        isError,
        isSuccess,
        forceResendingToken,
        verificationId,
      ];
}
