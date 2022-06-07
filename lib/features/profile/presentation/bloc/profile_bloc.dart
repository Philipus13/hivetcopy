import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/features/otp/model/otp_check_verify_model.dart';
import 'package:hivet/features/profile/model/profile_model.dart'
    as profileModel;
import 'package:hivet/features/profile/service/profile_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final instance = g<ProfileService>();

  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileInitEvent>(_getProfile);
    on<changePasswordEvent>(_changePassword);
  }

  void _changePassword(
    changePasswordEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ChangePassLoadingState());

    try {
      final changePass = await instance
          .changePassword(event.oldPassword, event.newPassword)
          .then(
              (value) => profileModel.profileModelFromJson(json.encode(value)));
      if (changePass.success!) {
        emit(ChangePassSuccessState());
      } else {
        emit(ChangePassFailedState(message: changePass.message));
      }
    } on RemoteDataSourceException catch (e) {
      if (e.fieldError != null) {
        emit(ChangePassFailedState(message: e.fieldError![0].message));
      } else {
        emit(ChangePassFailedState(message: e.message));
      }
    }
  }

  void _getProfile(
    ProfileInitEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());

    try {
      final getProfile = await instance.getProfile().then(
          (value) => profileModel.profileModelFromJson(json.encode(value)));

      final checkVerify = await instance
          .checkVerify()
          .then((value) => otpCheckVerifyModelFromJson(json.encode(value)));
      bool isVerified = false;
      if (checkVerify.data!) {
        isVerified = true;
      }

      emit(ProfileLoadedState(
          profileResponseModel: getProfile.data, isVerified: isVerified));
    } on RemoteDataSourceException catch (e) {
      emit(ProfileNotLoadedState(message: e.message));
    }
  }
}
