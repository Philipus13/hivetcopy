part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final profileModel.Data? profileResponseModel;
  final bool? isVerified;

  ProfileLoadedState({this.profileResponseModel, this.isVerified});

  @override
  List<Object?> get props => [this.profileResponseModel, this.isVerified];
}

class ProfileNotLoadedState extends ProfileState {
  final String? message;

  ProfileNotLoadedState({this.message});

  @override
  List<Object?> get props => [this.message];
}

class ChangePassLoadingState extends ProfileState {}

class ChangePassSuccessState extends ProfileState {}

class ChangePassFailedState extends ProfileState {
  final String? message;

  ChangePassFailedState({this.message});

  @override
  List<Object?> get props => [this.message];
}
