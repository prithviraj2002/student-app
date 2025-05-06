abstract class StudentEvent{}

class GetStudentData extends StudentEvent{
  final String studentId;

  GetStudentData({required this.studentId});
}