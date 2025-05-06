import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';

abstract class BoardState{}

class InitialState extends BoardState{}

class OngoingReqLoading extends BoardState{}

class OngoingReqError extends BoardState{
  final String errorMsg;

  OngoingReqError({required this.errorMsg});
}

class OngoingReqData extends BoardState{
  final List<ScribeRequest> reqs;
  final List<ScribeRequest> completedReqs;

  OngoingReqData({required this.reqs, required this.completedReqs});
}

class CompletedReqLoading extends BoardState{}

class CompletedReqError extends BoardState{
  final String errorMsg;

  CompletedReqError({required this.errorMsg});
}

class CompletedReqData extends BoardState{
  final List<ScribeRequest> reqs;

  CompletedReqData({required this.reqs});
}