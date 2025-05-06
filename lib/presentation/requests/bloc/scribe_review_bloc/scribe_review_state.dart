abstract class ScribeReviewState{}

class InitialState extends ScribeReviewState{}

class ScribeReviewLoading extends ScribeReviewState{}

class ScribeReviewError extends ScribeReviewState{
  final String errorMsg;

  ScribeReviewError({required this.errorMsg});
}

class ScribeReviewDone extends ScribeReviewState{}

class CompleteReqLoading extends ScribeReviewState{}

class CompleteReqError extends ScribeReviewState{
  final String errorMsg;

  CompleteReqError({required this.errorMsg});
}

class CompleteReqDone extends ScribeReviewState{}