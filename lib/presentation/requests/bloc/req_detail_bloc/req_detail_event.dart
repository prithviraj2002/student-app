abstract class ReqDetailEvent{}

class GetInterestedScribes extends ReqDetailEvent{
  final String reqId;

  GetInterestedScribes({required this.reqId});
}

class SelectScribe extends ReqDetailEvent{
  final String scribeReqId;
  final String scribeId;

  SelectScribe({required this.scribeReqId, required this.scribeId});
}