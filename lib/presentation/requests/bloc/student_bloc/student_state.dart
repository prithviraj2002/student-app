import 'package:student/domain/model/student_model/student_model.dart';

abstract class StudentState{}

class InitialState extends StudentState{}

class StudentData extends StudentState{
  final StudentModel student;

  StudentData({required this.student});
}

class StudentLoading extends StudentState{}

class StudentDataError extends StudentState{
  final String errorMsg;

  StudentDataError({required this.errorMsg});
}