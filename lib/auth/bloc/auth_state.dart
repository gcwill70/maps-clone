part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  initializing,
  initialized,
  authenticating,
  authenticated,
  unauthenticating,
  unauthenticated,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthUser? authUser;

  const AuthState({
    this.status = AuthStatus.initial,
    this.authUser,
  });

  @override
  List<Object?> get props => [status, authUser];

  AuthState copyWith({
    AuthStatus? status,
    AuthUser? authUser,
  }) {
    return AuthState(
      status: status ?? this.status,
      authUser: authUser ?? this.authUser,
    );
  }
}
