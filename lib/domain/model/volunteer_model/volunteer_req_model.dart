class VolunteerRequest{
  final String scribeReqId;
  final String scribeId;
  final bool isOpen;

  VolunteerRequest({
    required this.scribeReqId,
    required this.scribeId,
    this.isOpen = true
  });

  Map<String, dynamic> toJson(){
    return {
      "scribeReqId": scribeReqId,
      "scribeId": scribeId,
      "isOpen": isOpen
    };
  }

  factory VolunteerRequest.fromJson(Map<String, dynamic> json){
    return VolunteerRequest(
        scribeReqId: json['scribeReqId'],
        scribeId: json['scribeId'],
        isOpen: true
    );
  }
}