import 'package:student/domain/model/scribe_model/scribe_model.dart';

abstract class ReqDetailState{}

class InitialState extends ReqDetailState{}

class LoadingInterestedScribes extends ReqDetailState{}

class FailedInterestedScribes extends ReqDetailState{
  final String errorMsg;

  FailedInterestedScribes({required this.errorMsg});
}

class InterestedScribesData extends ReqDetailState{
  final List<ScribeModel> scribes;

  InterestedScribesData({required this.scribes});
}

class ScribeSelectSuccess extends ReqDetailState{}

class ScribeSelectLoading extends ReqDetailState{}

class ScribeSelectError extends ReqDetailState{
  final String errorMsg;

  ScribeSelectError({required this.errorMsg});
}