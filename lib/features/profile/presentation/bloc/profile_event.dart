part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileInitEvent extends ProfileEvent {
  const ProfileInitEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class changePasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  const changePasswordEvent(this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [oldPassword, newPassword];
}
