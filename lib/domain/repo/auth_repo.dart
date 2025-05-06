import 'package:firebase_auth/firebase_auth.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/data/db/student_api_service.dart';
import 'package:student/data/endpoints.dart';

class AuthRepo{
  FirebaseAuth auth = FirebaseAuth.instance;
  StudentApiService service = getIt<StudentApiService>();

  Future<void> setUserRole(String uid) async{
    return await service.setUserRole(
        {
          'uid': uid,
          'role': 'student'
        }
    );
  }

  Future<dynamic> getUserRole(String uid) async{
    final response = await service.getUserRole('${Endpoints.getUserRole}?uid=$uid');

    return response;
  }
}