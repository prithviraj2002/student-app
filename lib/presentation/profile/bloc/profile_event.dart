import 'package:student/domain/model/student_model/gender_model.dart';

abstract class ProfileEvent{}

class GetStudentData extends ProfileEvent{}

class Logout extends ProfileEvent{}

class UpdateProfile extends ProfileEvent{
  final Gender gender;

  UpdateProfile({required this.gender});
}

class DeleteProfile extends ProfileEvent{}