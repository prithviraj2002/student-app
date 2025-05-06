abstract class ReviewEvent{}

class GetReviews extends ReviewEvent{
  final String scribeId;

  GetReviews({required this.scribeId});
}