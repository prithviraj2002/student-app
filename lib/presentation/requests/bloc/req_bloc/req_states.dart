import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';

abstract class RequestState{}

class InitialRequestState extends RequestState{}

class LoadingScribeReq extends RequestState{}

class ScribeReqError extends RequestState{
  final String errorMsg;

  ScribeReqError({required this.errorMsg});
}

class ScribeReqData extends RequestState{
  final List<ScribeRequest> requests;

  ScribeReqData({required this.requests});
}
