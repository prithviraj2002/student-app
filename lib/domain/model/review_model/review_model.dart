class ReviewModel{
  final String scribeId;
  final String studentId;
  final String reviewText;
  final String createdAt;
  final int rating;

  ReviewModel({
    required this.scribeId,
    required this.studentId,
    required this.reviewText,
    required this.createdAt,
    required this.rating
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json){
    return ReviewModel(
        scribeId: json['scribeId'],
        studentId: json['studentId'],
        reviewText: json['reviewText'],
        rating: json['rating'],
      createdAt: json['createdAt']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'scribeId': scribeId,
      'studentId': studentId,
      'reviewText': reviewText,
      'rating': rating
    };
  }
}