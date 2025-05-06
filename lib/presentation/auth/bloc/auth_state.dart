abstract class AuthState{}

class AuthInitial extends AuthState{}

class AuthFailed extends AuthState{
  final String errorMsg;

  AuthFailed({required this.errorMsg});
}

class AuthCodeSent extends AuthState{
  final String verificationId;
  final int? resendToken;

  AuthCodeSent({required this.verificationId, this.resendToken});
}

class AuthLoading extends AuthState{}

class AuthSuccess extends AuthState{}

class AuthLogoutSuccess extends AuthState{}