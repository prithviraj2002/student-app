import 'package:student/core/locator/locator.dart';
import 'package:student/data/db/student_api_service.dart';
import 'package:student/domain/model/student_model/student_model.dart';

class ProfileRepo{
  StudentApiService service = getIt<StudentApiService>();

  Future<StudentModel> getStudentProfile() async{
    final response = await service.getStudentProfile();

    return StudentModel.fromJson(response['data']);
  }

  Future<dynamic> updateStudentProfile(Map<String, dynamic> data) async{
    return await service.updateStudentProfile(data);
  }
}