import 'package:student/core/locator/locator.dart';
import 'package:student/data/db/student_api_service.dart';

class HomeRepo{
  StudentApiService service = getIt<StudentApiService>();
}