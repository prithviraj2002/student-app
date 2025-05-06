import 'package:student/core/locator/locator.dart';
import 'package:student/data/db/student_api_service.dart';
import 'package:student/domain/model/student_model/student_model.dart';

class RegisterRepo{
  StudentApiService service = getIt<StudentApiService>();

  Future<dynamic> registerStudent(StudentModel student) async{
    return await service.createStudent(student);
  }

  Future<dynamic> checkStudentProfile() => service.checkStudentProfile();
}