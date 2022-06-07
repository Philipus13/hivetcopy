import 'package:equatable/equatable.dart';

class ForgotState extends Equatable {
  final String? token;
  final bool? isLoading;
  final String? message;
  final bool? isError;
  final bool? isSuccess;
  final int? forceResendingToken;
  //0 -> init , 1 -> email, 2 -> phoneinit, 3 -> phoneverify
  final int? status;
  final String? verificationId;

  const ForgotState({
    this.token,
    this.isLoading = false,
    this.message,
    this.isError = false,
    this.isSuccess = false,
    this.forceResendingToken = 0,
    this.status = 0,
    this.verificationId,
  });

  factory ForgotState.initialData() {
    return ForgotState(
      isLoading: false,
      message: null,
      isError: false,
      isSuccess: false,
      forceResendingToken: 0,
      status: 0,
      verificationId: null,
    );
  }
  ForgotState update({
    final String? token,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    int? forceResendingToken,
    int? status,
    String? verificationId,
  }) =>
      ForgotState(
        token: token ?? this.token,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        isError: isError ?? this.isError,
        isSuccess: isSuccess ?? this.isSuccess,
        forceResendingToken: forceResendingToken ?? this.forceResendingToken,
        status: status ?? this.status,
        verificationId: verificationId ?? this.verificationId,
      );
  ForgotState delete({
    final String? token,
    bool? isLoading,
    String? message,
    bool? isError,
    bool? isSuccess,
    int? forceResendingToken,
    int? status,
    String? verificationId,
  }) =>
      ForgotState(
        token: null,
        isLoading: false,
        message: null,
        isError: false,
        isSuccess: false,
        forceResendingToken: 0,
        status: 0,
        verificationId: null,
      );

  @override
  List<Object?> get props => [
        isLoading,
        message,
        isError,
        isSuccess,
        forceResendingToken,
        status,
        verificationId,
      ];
}
