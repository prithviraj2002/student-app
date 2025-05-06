abstract class ScribeReviewEvent{}

class CreateScribeReview extends ScribeReviewEvent{
  final String scribeId; final String reviewText; final int rating;

  CreateScribeReview({required this.scribeId, required this.reviewText, required this.rating});
}

class CompleteReq extends ScribeReviewEvent{
  final String id; final String selectedScribeId;

  CompleteReq({required this.id, required this.selectedScribeId});
}