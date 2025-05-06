abstract class RegisterState{}

class RegisterInitial extends RegisterState{}

class GoToHome extends RegisterState{}

class RegisterStudentLoading extends RegisterState{}

class RegisterStudentSuccess extends RegisterState{}

class RegisterStudentError extends RegisterState{
  final String errorMsg;

  RegisterStudentError({required this.errorMsg});
}