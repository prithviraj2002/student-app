import 'package:student/domain/model/student_model/student_model.dart';

abstract class ProfileState{}

class ProfileInitial extends ProfileState{}

class StudentDataLoadingState extends ProfileState{}

class StudentDataState extends ProfileState{
  final StudentModel student;

  StudentDataState({required this.student});
}

class StudentDataErrorState extends ProfileState{
  final String errorMsg;

  StudentDataErrorState({required this.errorMsg});
}

class LogoutProfileLoading extends ProfileState{}

class LogoutProfileError extends ProfileState{
  final String errorMsg;

  LogoutProfileError({required this.errorMsg});
}

class LogoutProfileDone extends ProfileState{}

//Delete account states.
class DeleteAccountDone extends ProfileState{}

class DeleteAccountLoading extends ProfileState{}

class DeleteAccountErrorState extends ProfileState{
  final String errorMsg;

  DeleteAccountErrorState({required this.errorMsg});
}

//Update profile states.
class UpdateProfileLoading extends ProfileState{}

class UpdateProfileError extends ProfileState{
  final String errorMsg;

  UpdateProfileError({required this.errorMsg});
}

class UpdateProfileDone extends ProfileState{}