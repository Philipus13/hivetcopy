import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hivet/core/exception/remote_data_source_exception.dart';
import 'package:hivet/core/injection/service_locator.dart';
import 'package:hivet/features/profile/service/profile_service.dart';
import 'package:hivet/features/profile/model/profile_model.dart'
    as profileModel;

part 'update_profile_event.dart';
part 'update_profile_state.dart';


class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final instance = g<ProfileService>();

  UpdateProfileBloc() : super(ProfileInitialState()) {
    on<UpdatingProfileEvent>(_updateProfile);
  }

  void _updateProfile(
    UpdatingProfileEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoadingState());

    try {
      final updateProfile = await instance.postUserProfile(event.data).then(
          (value) => profileModel.profileModelFromJson(json.encode(value)));

      emit(UpdatedProfileState(profileResponseModel: updateProfile.data));
    } on RemoteDataSourceException catch (e) {
      emit(UpdatedProfileFailedState(message: e.message));
    }
  }
}
