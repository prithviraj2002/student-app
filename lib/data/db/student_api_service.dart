import 'package:student/core/locator/locator.dart';
import 'package:student/data/client/student_client.dart';
import 'package:student/data/endpoints.dart';
import 'package:student/domain/model/review_model/review_model.dart';
import 'package:student/domain/model/student_model/student_model.dart';

class StudentApiService{
  StudentClient client = getIt<StudentClient>();

  //User functions
  Future<dynamic> setUserRole(Map<String, dynamic> data) async{
    return await client.post(Endpoints.setUserRole, data);
  }

  Future<dynamic> getUserRole(String endpoint) async{
    return await client.get(endpoint);
  }

  //Student functions
  Future<dynamic> createStudent(StudentModel studentModel) async{
    return await client.post(Endpoints.student, studentModel.toJson());
  }

  Future<dynamic> checkStudentProfile() async{
    return await client.get(Endpoints.checkStudent);
  }

  Future<dynamic> getStudentProfile() async{
    return await client.get(Endpoints.studentProfile);
  }

  Future<dynamic> getStudentFromId(String id) async{
    return await client.get(Endpoints.student + id);
  }
  
  Future<dynamic> updateStudentProfile(Map<String, dynamic> data) async{
    return await client.patch(Endpoints.student, data);
  }

  //Scribe functions
  Future<dynamic> getAllScribes() async{
    return await client.get(Endpoints.scribeAll);
  }

  Future<dynamic> getInterestedScribes(String reqId) async{
    return await client.get(Endpoints.interestedScribes + reqId);
  }

  Future<dynamic> getScribeFromId(String id) async{
    return await client.get("${Endpoints.scribe}/$id");
  }

  //Scribe request functions
  Future<dynamic> getScribeReq({String isComplete = 'false', String isOpen = 'true'}) async{
    return await client.get('${Endpoints.student}${Endpoints.scribeReq}?isComplete=$isComplete&isOpen=$isOpen');
  }

  Future<dynamic> updateScribeReq(Map<String, dynamic> data, String id) async{
    return await client.patch("${Endpoints.scribeReq}/$id", data);
  }

  Future<dynamic> createScribeReq(Map<String, dynamic> data) async{
    return await client.post(Endpoints.scribeReq, data);
  }

  Future<dynamic> getScribeReviews(String id) async{
    return await client.get('${Endpoints.review}/$id');
  }

  Future<dynamic> createScribeReview(ReviewModel review) async{
    return await client.post(
        Endpoints.review,
        review.toJson()
    );
  }
}