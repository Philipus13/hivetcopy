import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hivet/core/config/global_translations.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/local/user_secure_storage.dart';
import 'package:hivet/features/auth/sign_in/model/sign_in_response_model.dart';
import 'package:hivet/features/auth/sign_in/service/sign_in_service.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final instance = g<SignInService>();

  // SignInBloc() : super(SignInInitial());

  SignInBloc() : super(SignInInitial()) {
    on<SignInAccountEvent>(_onSignInEmail);
    on<SaveTokenToLocalEvent>(_onSaveLocalToken);
  }

  // SignInService _service = SignInService();

  void _onSignInEmail(
    SignInAccountEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());
    try {
      final getSignIn = await instance
          .signInAccount(username: event.username, password: event.password)
          .then((value) => signInResponseModelFromJson(json.encode(value)));
      emit(SignInSuccess(signInResponseModel: getSignIn));
    } on RemoteDataSourceException catch (e) {
      emit(SignInError(errMessage: e.message));
    } catch (e) {
      emit(SignInError(
          errMessage: allTranslations.text('auth.login_failed_message')));
    }
  }

  void _onSaveLocalToken(
    SaveTokenToLocalEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoading());

    String token = event.signInResponseModel!.tokenType! +
        " " +
        event.signInResponseModel!.accessToken!;
    try {
      await UserSecureStorage.setToken(token) ?? '';
      await UserSecureStorage.setScopes(event.signInResponseModel!.scopes!) ??
          '';
      emit(SaveTokenSuccess(scopes: event.signInResponseModel!.scopes!));
    } catch (e) {
      emit(SaveTokenError());
    }
  }
}
