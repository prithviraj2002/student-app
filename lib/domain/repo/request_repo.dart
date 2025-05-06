import 'package:student/core/locator/locator.dart';
import 'package:student/data/db/student_api_service.dart';
import 'package:student/domain/model/review_model/review_model.dart';
import 'package:student/domain/model/scribe_model/scribe_model.dart';
import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';
import 'package:student/domain/model/student_model/student_model.dart';

class RequestRepo{
  StudentApiService service = getIt<StudentApiService>();

  Future<dynamic> getScribeReq() => service.getScribeReq();

  Future<dynamic> getCompletedReq() async{
    List<ScribeRequest> reqs = [];
    final response = await service.getScribeReq(isComplete: 'true', isOpen: 'false');

    for(var req in response['data']){
      reqs.add(ScribeRequest.fromJson(req));
    }

    return reqs;
  }

  Future<dynamic> getOngoingReq() async{
    List<ScribeRequest> reqs = [];
    final response = await service.getScribeReq(isOpen: 'false');

    for(var req in response['data']){
      reqs.add(ScribeRequest.fromJson(req));
    }

    return reqs;
  }

  Future<dynamic> getInterestedScribes(String reqId) async{
    List<ScribeModel> scribes = [];
    final response = await service.getInterestedScribes(reqId);

    for(Map<String, dynamic> scribe in response['scribes']){
      scribes.add(ScribeModel.fromJson(scribe));
    }

    return scribes;
  }

  Future<dynamic> getScribeReviews(String id) async{
    List<ReviewModel> reviews = [];
    final response = await service.getScribeReviews(id);

    for(Map<String, dynamic> review in response['data']){
      reviews.add(ReviewModel.fromJson(review));
    }

    return reviews;
  }

  Future<void> createScribeReview(ReviewModel review) => service.createScribeReview(review);

  Future<StudentModel> getStudentFromId(String id) async{
    final response = await service.getStudentFromId(id);

    return StudentModel.fromJson(response['data']);
  }

  Future<void> updateScribeReq(String id, Map<String, dynamic> data) =>
      service.updateScribeReq(data, id);

  Future<ScribeModel> getScribeFromId(String id) async{
    final response = await service.getScribeFromId(id);

    return ScribeModel.fromJson(response['data']);
  }
}