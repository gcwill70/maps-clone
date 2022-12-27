import 'dart:async';

import 'package:auth_api/auth_api.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepo;
  late final StreamSubscription _authUserSub;

  AuthBloc(this._authRepo) : super(const AuthState()) {
    on<Authenticate>((event, emit) async {
      try {
        emit(state.copyWith(status: AuthStatus.authenticating));
        await _authRepo.authenticate(event.provider);
      } catch (_) {
        emit(state.copyWith(status: AuthStatus.error));
      }
    });
    on<Unauthenticate>((event, emit) async {
      try {
        emit(state.copyWith(status: AuthStatus.unauthenticating));
        await _authRepo.unauthenticate();
      } catch (_) {
        emit(state.copyWith(status: AuthStatus.error));
      }
    });
    on<AuthUserChangedEvent>((event, emit) async {
      if (event.authUser == null) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      } else {
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          authUser: event.authUser,
        ));
      }
    });
    _authUserSub = _authRepo.user.listen((authUser) {
      add(AuthUserChangedEvent(authUser));
    });
  }

  @override
  Future<void> close() async {
    await _authUserSub.cancel();
    super.close();
  }
}
