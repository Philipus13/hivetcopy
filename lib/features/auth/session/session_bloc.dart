import 'package:bloc/bloc.dart';
import 'package:hivet/core/config/common_constant.dart';

import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/core/local/user_secure_storage.dart';
import 'package:hivet/features/auth/session/service/session_service.dart';
import 'package:hivet/features/auth/session/session_event.dart';
import 'package:hivet/features/auth/session/session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final instance = g<SessionService>();

  SessionBloc() : super(SessionInitialState()) {
    on<SessionInitEvent>(_onEnteringApps);

    on<SessionLoggedInEvent>(_onLoginUser);
    on<SessionLoggedOutEvent>(_onLogOut);
  }

  void _onEnteringApps(
    SessionInitEvent event,
    Emitter<SessionState> emit,
  ) async {
    bool status = await instance.checkToken();

    if (status) {
      final scopes = await UserSecureStorage.getScopes() ?? "";

      switch (scopes) {
        case CommonConstants.pengguna:
          emit(SessionLoggedinUserState());
          break;
        case CommonConstants.doctor:
          emit(SessionLoggedInDoctorState());
          break;
        case CommonConstants.toko:
          emit(SessionLoggedInStoreState());
          break;
        default:
      }
    } else {
      emit(SessionNoToken());
    }
  }

  void _onLoginUser(
    SessionLoggedInEvent event,
    Emitter<SessionState> emit,
  ) async {
    switch (event.scopes) {
      case CommonConstants.pengguna:
        emit(SessionLoggedinUserState());
        break;
      case CommonConstants.doctor:
        emit(SessionLoggedInDoctorState());
        break;
      case CommonConstants.toko:
        emit(SessionLoggedInStoreState());
        break;
      default:
    }
  }

  void _onLogOut(
    SessionLoggedOutEvent event,
    Emitter<SessionState> emit,
  ) async {
    bool logout = await instance.deleteToken();
    if (logout) {
      emit(SessionLogout("You've just logout"));
    }
  }
}
