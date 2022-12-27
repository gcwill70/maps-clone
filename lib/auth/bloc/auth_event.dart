part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class Authenticate extends AuthEvent {
  final AuthProvider provider;

  const Authenticate(this.provider);

  @override
  List<Object> get props => [provider];
}

class Unauthenticate extends AuthEvent {}

class AuthUserChangedEvent extends AuthEvent {
  final AuthUser? authUser;

  const AuthUserChangedEvent(this.authUser);

  @override
  List<Object> get props => [authUser ?? AuthUser()];
}
