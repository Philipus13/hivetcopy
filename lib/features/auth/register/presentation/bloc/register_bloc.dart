import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/local/user_secure_storage.dart';
import 'package:hivet/features/auth/register/service/register_service.dart';
import 'package:hivet/features/auth/sign_in/model/sign_in_response_model.dart';
import 'package:hivet/features/auth/sign_in/service/sign_in_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final instance = g<RegisterService>();
  final instanceLogin = g<SignInService>();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUserEvent>(_onRegistered);
    on<RegisterSuccessEvent>(_onSuccess);
  }
  void _onSuccess(
    RegisterSuccessEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final getSignIn = await instanceLogin
          .signInAccount(username: event.username, password: event.password)
          .then((value) => signInResponseModelFromJson(json.encode(value)));
      String token = getSignIn.tokenType! + " " + getSignIn.accessToken!;
      try {
        await UserSecureStorage.setToken(token) ?? '';
        await UserSecureStorage.setScopes(getSignIn.scopes!) ?? '';

        emit(RegisterVerified(
            event.countryCode, event.phone, getSignIn.scopes!));
      } catch (e) {
        // emit(SaveTokenError());
      }

      // emit(RegisterVerified(event.countryCode, event.phone));
    } on RemoteDataSourceException catch (e) {
      emit(RegisterFailed(errorMessage: e.message));
    } catch (e) {
      emit(RegisterFailed(
          errorMessage: allTranslations.text('auth.register_failed_message')));
    }
  }

  void _onRegistered(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      var data = {
        "full_name": event.fullName,
        "username": event.username,
        "email": event.email,
        "password": event.password,
        "country_code": event.countryCode,
        "phone": event.phone
      };

      emit(await instance
          .registerAccount(data)
          .then((value) => RegisterSuccess()));
      // emit(RegisterSuccess());
    } on RemoteDataSourceException catch (e) {
      emit(RegisterFailed(errorMessage: e.message));
    } catch (e) {
      emit(RegisterFailed(
          errorMessage: allTranslations.text('auth.register_failed_message')));
    }
  }
}
