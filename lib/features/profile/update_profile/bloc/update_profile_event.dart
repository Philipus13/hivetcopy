part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileInitEvent extends UpdateProfileEvent {
  const ProfileInitEvent();
}

class UpdatingProfileEvent extends UpdateProfileEvent {
  final profileModel.Data? data;

  const UpdatingProfileEvent(this.data);
  @override
  List<Object?> get props => [data];
}
