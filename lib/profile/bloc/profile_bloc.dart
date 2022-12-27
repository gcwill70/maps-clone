import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:profile_api/profile_api.dart';
import 'package:profile_repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repo;

  ProfileBloc(this._repo) : super(ProfileInitial()) {
    on<ProfileLoad>((event, emit) async {
      if (state is ProfileLoading) {
        return;
      }
      emit(ProfileLoading());
      try {
        final profile = await _repo.getProfile(event.id);
        emit(ProfileLoaded(profile));
      } on ProfileNotFoundException catch (notFoundException) {
        emit(ProfileNotFound(notFoundException.id));
      } catch (_) {
        emit(ProfileError());
      }
    });
    on<ProfileSave>((event, emit) async {
      if (state is ProfileLoading) {
        return;
      }
      emit(ProfileLoading());
      try {
        await _repo.saveProfile(event.profile);
        emit(ProfileLoaded(event.profile));
      } catch (_) {
        emit(ProfileError());
      }
    });
  }
}
