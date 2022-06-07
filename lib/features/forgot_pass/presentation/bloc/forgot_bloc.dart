import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/features/forgot_pass/model/forgot_pass_phone_model.dart';
import 'package:hivet/features/forgot_pass/presentation/bloc/forgot_state.dart';
import 'package:hivet/features/forgot_pass/service/forgot_service.dart';

part 'forgot_event.dart';

class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final instance = g<ForgotService>();

  ForgotBloc() : super(ForgotState.initialData()) {
    on<ForgotVerifyPhoneEvent>(_verifyPhone);
    on<ForgotVerifyEmailEvent>(_verifyEmail);
    on<ForgotResetCodeEvent>(_resetForgot);
    on<ForgotChangePassEvent>(_submitChangePass);
    on<ForgotCodeSentEvent>(_codeSendOTP);
    on<ForgotGoToEmailEvent>(goToEmail);
    on<ForgotGoToPhoneEvent>(goToPhone);
    on<ForgotDeleteEvent>(deleteState);
  }

  void goToEmail(
    ForgotGoToEmailEvent event,
    Emitter<ForgotState> emit,
  ) async {
    emit(state.update(
      status: 1,
    ));
  }

  void goToPhone(
    ForgotGoToPhoneEvent event,
    Emitter<ForgotState> emit,
  ) async {
    emit(state.update(
      status: 2,
    ));
  }

  void deleteState(
    ForgotDeleteEvent event,
    Emitter<ForgotState> emit,
  ) async {
    emit(state.delete());
  }

  void _verifyEmail(
    ForgotVerifyEmailEvent event,
    Emitter<ForgotState> emit,
  ) async {
    try {
      emit(state.update(isLoading: true, isSuccess: false, isError: false));

      try {
        var body = {
          "email": event.email,
        };

        // instance.verifyPhone(body);

        final verifyEmail = await instance.forgotbyEmail(body).then(
            (value) => forgotCheckVerifyModelFromJson(json.encode(value)));

        if (verifyEmail.success!) {
          emit(state.update(
              isSuccess: true,
              isLoading: false,
              message: allTranslations.text('forgot.email_success')));
        } else {
          emit(state.update(
              isLoading: false, isError: true, message: verifyEmail.message));
        }
      } on RemoteDataSourceException catch (e) {
        String message = e.message;
        if (e.message ==
            'The user with this email does not exist in the system.') {
          message = allTranslations.text('forgot.email_not_found');
        }
        emit(state.update(
          isLoading: false,
          isError: true,
          message: message,
        ));
      }

      emit(state.update(
        isLoading: false,
      ));
    } catch (e) {
      emit(state.update(
        isLoading: false,
      ));
      // print('ini error: ' + e.toString());
    }
  }

  void _verifyPhone(
    ForgotVerifyPhoneEvent event,
    Emitter<ForgotState> emit,
  ) async {
    try {
      emit(state.update(isLoading: true, isSuccess: false, isError: false));

      final phoneVerificationCompleted = (AuthCredential authCredential) {
        print('_mapVerifyPhoneNumberToState PhoneVerificationCompleted');
      };
      final phoneVerificationFailed = (FirebaseAuthException authException) {
        this.add(ForgotVerificationFailed(authException.message));
      };
      final phoneCodeSent = (String verificationId, [int? forceResent]) {
        print('_mapVerifyPhoneNumberToState PhoneCodeSent');
        this.add(ForgotCodeSentEvent(verificationId, forceResent));
      };
      final phoneCodeAutoRetrievalTimeout = (String verificationId) {
        print('_mapVerifyPhoneNumberToState PhoneCodeAutoRetrievalTimeout');
      };

      var body = {"country_code": event.countryCode, "phone": event.phoneNum};

      try {
        final verifyPhone = await instance.forgotbyPhone(body).then(
            (value) => forgotCheckVerifyModelFromJson(json.encode(value)));

        if (verifyPhone.success!) {
          await instance.sendForgotFirebase(
              phoneNumber: event.countryCode + event.phoneNum,
              timeOut: Duration(seconds: 0),
              phoneVerificationFailed: phoneVerificationFailed,
              phoneVerificationCompleted: phoneVerificationCompleted,
              phoneCodeSent: phoneCodeSent,
              autoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
          emit(state.update(isLoading: false, token: verifyPhone.data));
        } else {
          emit(state.update(
              isLoading: false, isError: true, message: verifyPhone.message));
        }
      } on RemoteDataSourceException catch (e) {
        String message = e.message;
        if (e.message ==
            'The user with this phone does not exist in the system.') {
          message = allTranslations.text('forgot.phone_not_found');
        }
        emit(state.update(
          isLoading: false,
          isError: true,
          message: message,
        ));
      }

      // await instance.sendForgotFirebase(
      //     phoneNumber: event.countryCode + event.phoneNum,
      //     timeOut: Duration(seconds: 0),
      //     phoneVerificationFailed: phoneVerificationFailed,
      //     phoneVerificationCompleted: phoneVerificationCompleted,
      //     phoneCodeSent: phoneCodeSent,
      //     autoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);

      // emit(state.update(
      //   isLoading: false,
      // ));
    } catch (e) {
      emit(state.update(
        isLoading: false,
      ));
      // print('ini error: ' + e.toString());
    }
  }

  void _submitChangePass(
    ForgotChangePassEvent event,
    Emitter<ForgotState> emit,
  ) async {
    emit(state.update(isLoading: true, isSuccess: false, isError: false));

    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: event.verificationId, smsCode: event.otpCode);

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        print('api verified');
        try {
          var body = {
            "token": event.verificationToken,
            "new_password": event.newPass
          };

          final verifyPhone = await instance.submitChangePass(body).then(
              (value) => forgotCheckVerifyModelFromJson(json.encode(value)));

          if (verifyPhone.success!) {
            emit(state.update(
                isSuccess: true,
                isLoading: false,
                message: allTranslations.text('forgot.phone_success')));
          } else {
            emit(state.update(
                isLoading: false, isError: true, message: verifyPhone.message));
          }
        } on RemoteDataSourceException catch (e) {
          emit(state.update(
            isLoading: false,
            isError: true,
            message: e.message,
          ));
        }
      } else {
        //user not verified
        emit(state.update(
            isError: true,
            message: allTranslations.text('forgot.wrong_verify_code'),
            isLoading: false));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        emit(state.update(
            isError: true,
            message: allTranslations.text('forgot.wrong_verify_code'),
            isLoading: false));
      }
      // print('ini dia: ' + e.message!);
    }
  }

  void _codeSendOTP(
    ForgotCodeSentEvent event,
    Emitter<ForgotState> emit,
  ) async {
    emit(state.update(
        isLoading: false,
        status: 3,
        verificationId: event.verificationId,
        forceResendingToken: event.forceResent));
  }

  void _resetForgot(
    ForgotResetCodeEvent event,
    Emitter<ForgotState> emit,
  ) async {
    emit(state.update(isLoading: true, isSuccess: false, isError: false));

    await _auth.verifyPhoneNumber(
        phoneNumber: event.countryCode + event.phoneNum,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: (verificationId, forceResendingToken) {
          this.add(ForgotCodeSentEvent(verificationId, forceResendingToken));
        },
        forceResendingToken: state.forceResendingToken,
        codeAutoRetrievalTimeout: _onCodeTimeout);
    // emit(state.update(
    //   isLoading: false,
    // ));
  }

  _onCodeTimeout(String timeout) {
    print('timeout');

    return null;
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    // if (exception.code == 'invalid-phone-number') {
    //   showMessage("The phone number entered is invalid!");
    // }
  }
}
