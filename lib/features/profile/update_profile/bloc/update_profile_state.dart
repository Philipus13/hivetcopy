part of 'update_profile_bloc.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object?> get props => [];
}

class UpdateProfileLoadingState extends UpdateProfileState {}

class ProfileInitialState extends UpdateProfileState {}

class UpdatedProfileState extends UpdateProfileState {
  final profileModel.Data? profileResponseModel;

  UpdatedProfileState({this.profileResponseModel});

  @override
  List<Object?> get props => [this.profileResponseModel];
}

class UpdatedProfileFailedState extends UpdateProfileState {
  final String? message;

  UpdatedProfileFailedState({this.message});

  @override
  List<Object?> get props => [this.message];
}
