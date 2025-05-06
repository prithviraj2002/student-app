class ScribeRequest{
  final String examName;
  final String subject;
  final String language;
  final String date;
  final String time;
  final int duration;
  final String address;
  final String city;
  final String pincode;
  final String board;
  final String modeOfExam;
  final String studentId;
  final String? scribeId;
  final bool isOpen;
  final bool isComplete;
  final String id;

  ScribeRequest({
    required this.examName,
    required this.subject,
    required this.language,
    required this.date,
    required this.time,
    required this.duration,
    required this.address,
    required this.city,
    required this.pincode,
    required this.board,
    required this.modeOfExam,
    required this.studentId,
    this.scribeId,
    this.isOpen = true,
    this.isComplete = false,
    required this.id,
  });

  factory ScribeRequest.fromJson(Map<String, dynamic> json){
    return ScribeRequest(
        examName: json['examName'],
        subject: json['subject'],
        language: json['language'],
        date: json['date'],
        time: json['time'],
        duration: json['duration'],
        address: json['address'],
        city: json['city'],
        pincode: json['pincode'],
        board: json['board'],
        modeOfExam: json['modeOfExam'],
        studentId: json['studentId'],
        id: json['_id'],
        scribeId: json['scribeId'] ?? "",
        isOpen: json['isOpen'],
      isComplete: json['isComplete']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'examName': examName,
      'subject': subject,
      'language': language,
      'date': date,
      'time': time,
      'duration': duration,
      'address': address,
      'city': city,
      'pincode': pincode,
      'board': board,
      'modeOfExam': modeOfExam,
      'studentId': studentId,
      'scribeId': null,
      'isOpen': true,
      'isComplete': false
    };
  }
}