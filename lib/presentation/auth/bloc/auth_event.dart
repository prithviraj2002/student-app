abstract class AuthEvent {}

class AuthLogin extends AuthEvent{}

class AuthSendOtp extends AuthEvent{
  final String phoneNumber;
  final int? resendToken;

  AuthSendOtp({required this.phoneNumber, this.resendToken});
}

class AuthVerifyOtp extends AuthEvent{
  final String otp;
  final String verificationId;

  AuthVerifyOtp({required this.otp, required this.verificationId});
}

class AuthEventCodeSent extends AuthEvent{
  final String verificationId;
  final int? resendToken;

  AuthEventCodeSent({required this.verificationId, this.resendToken});
}

class ResendOtp extends AuthEvent{}

class AuthEventSuccess extends AuthEvent{}

class AuthEventFailed extends AuthEvent{}

class AuthLogout extends AuthEvent{}
