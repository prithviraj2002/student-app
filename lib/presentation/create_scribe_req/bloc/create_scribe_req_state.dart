abstract class CreateScribeReqState{}

class InitialCreateScribeReq extends CreateScribeReqState{}

class CreateScribeReqLoading extends CreateScribeReqState{}

class CreateScribeReqError extends CreateScribeReqState{
  final String errorMsg;

  CreateScribeReqError({required this.errorMsg});
}

class CreateScribeReqDone extends CreateScribeReqState{}