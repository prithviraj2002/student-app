import 'package:student/domain/model/review_model/review_model.dart';

abstract class ReviewState{}

class InitialState extends ReviewState{}

class ReviewDataState extends ReviewState{
  final List<ReviewModel> reviews;

  ReviewDataState({required this.reviews});
}

class ReviewLoadingState extends ReviewState{}

class ReviewErrorState extends ReviewState{
  final String errorMsg;

  ReviewErrorState({required this.errorMsg});
}