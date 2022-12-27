part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoad extends ProfileEvent {
  final String id;

  const ProfileLoad(this.id);

  @override
  List<Object> get props => [id];
}

class ProfileSave extends ProfileEvent {
  final Profile profile;

  const ProfileSave(this.profile);

  @override
  List<Object> get props => [profile];
}
