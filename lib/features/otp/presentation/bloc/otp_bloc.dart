import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/features/otp/model/otp_verify_model.dart';
import 'package:hivet/features/otp/presentation/bloc/otp_state.dart';
import 'package:hivet/features/otp/service/otp_service.dart';

part 'otp_event.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final instance = g<OTPService>();

  OtpBloc() : super(OtpState.initialData()) {
    on<OtpInitEvent>(_initOTP);
    on<OtpResetCodeEvent>(_resetOtp);
    on<OtpSubmitEvent>(_submitOTP);
    on<OTPCodeSentEvent>(_codeSendOTP);
  }

  void _initOTP(
    OtpInitEvent event,
    Emitter<OtpState> emit,
  ) async {
    try {
      emit(state.update(isLoading: true, isSuccess: false, isError: false));

      // await _auth.verifyPhoneNumber(
      //     phoneNumber: event.phoneNum,
      //     verificationCompleted: _onVerificationCompleted,
      //     verificationFailed: (e) {
      //       emit(state.update(
      //           isError: true, isLoading: false, message: e.message));
      //     },
      //     codeSent: (verificationId, forceResendingToken) async {
      //    emit(state.update(
      //           forceResendingToken: forceResendingToken,
      //           verificationId: verificationId));
      //     },
      //     codeAutoRetrievalTimeout: _onCodeTimeout);
      final phoneVerificationCompleted = (AuthCredential authCredential) {
        print('_mapVerifyPhoneNumberToState PhoneVerificationCompleted');
        // _userRepository.getCurrentUser().catchError((onError) {
        //   print(onError);
        // }).then((user) {
        //   add(VerificationCompletedEvent(firebaseUser: user, isVerified: true));
        // });
        // this.add(event);
      };
      final phoneVerificationFailed = (FirebaseAuthException authException) {
        // print('_mapVerifyPhoneNumberToState PhoneVerificationFailed');
        // print(authException.message);
        // add(VerificationExceptionEvent(onError.toString()));
        this.add(OtpPhoneVerificationFailed(authException.message));
      };
      final phoneCodeSent = (String verificationId, [int? forceResent]) {
        print('_mapVerifyPhoneNumberToState PhoneCodeSent');
        // this.verificationId = verificationId;
        this.add(OTPCodeSentEvent(verificationId, forceResent));
        // emit(state.update(
        //     forceResendingToken: forceResent, verificationId: verificationId));
      };
      final phoneCodeAutoRetrievalTimeout = (String verificationId) {
        print('_mapVerifyPhoneNumberToState PhoneCodeAutoRetrievalTimeout');
        // emit(state.update(
        //   isLoading: false,
        // ));
        // this.verificationId = verificationId;
        // add(PhoneCodeAutoRetrievalTimeoutEvent(verificationId: verificationId));
      };

      await instance.sendOTPFirebase(
          phoneNumber: event.countryCode + event.phoneNum,
          timeOut: Duration(seconds: 0),
          phoneVerificationFailed: phoneVerificationFailed,
          phoneVerificationCompleted: phoneVerificationCompleted,
          phoneCodeSent: phoneCodeSent,
          autoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);

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

  void _submitOTP(
    OtpSubmitEvent event,
    Emitter<OtpState> emit,
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
            "country_code": event.countryCode,
            "phone": event.phone,
            "otp": false
          };

          // instance.verifyPhone(body);

          final verifyPhone = await instance
              .verifyPhone(body)
              .then((value) => otpVerifyModelFromJson(json.encode(value)));

          if (verifyPhone.success!) {
            emit(state.update(isSuccess: true, isLoading: false));
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
    OTPCodeSentEvent event,
    Emitter<OtpState> emit,
  ) async {
    // emit(state.update(
    //   isLoading: true,
    // ));

    emit(state.update(
        isLoading: false,
        verificationId: event.verificationId,
        forceResendingToken: event.forceResent));
  }

  void _resetOtp(
    OtpResetCodeEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.update(isLoading: true, isSuccess: false, isError: false));

    await _auth.verifyPhoneNumber(
        phoneNumber: event.countryCode + event.phoneNum,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: (verificationId, forceResendingToken) {
          this.add(OTPCodeSentEvent(verificationId, forceResendingToken));
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
