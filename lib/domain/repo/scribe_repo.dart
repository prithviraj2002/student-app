import 'package:student/core/locator/locator.dart';
import 'package:student/data/db/student_api_service.dart';

class ScribeRepo{
  StudentApiService service = getIt<StudentApiService>();

  Future<dynamic> getAllScribes() => service.getAllScribes();

  Future<dynamic> createScribeReq(Map<String, dynamic> data) => service.createScribeReq(data);
}