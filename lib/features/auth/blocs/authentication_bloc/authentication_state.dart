part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  unknown,
  registered,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._(
      {this.status = AuthenticationStatus.unknown, this.user});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated()
      : this._(status: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);
  
  const AuthenticationState.registered(): this._(status: AuthenticationStatus.registered);



  final AuthenticationStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}
