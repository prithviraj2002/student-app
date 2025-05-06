import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/domain/model/student_model/student_model.dart';
import 'package:student/domain/repo/request_repo.dart';
import 'package:student/presentation/requests/bloc/student_bloc/student_event.dart';
import 'package:student/presentation/requests/bloc/student_bloc/student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState>{
  final RequestRepo repo = getIt<RequestRepo>();

  StudentBloc(): super(InitialState()){
    on<GetStudentData>((event, emit) async{
      emit(StudentLoading());
      try{

        StudentModel student = await repo.getStudentFromId(event.studentId);

        emit(StudentData(student: student));
      } catch(e){
        emit(StudentDataError(errorMsg: e.toString()));
      }
    });
  }
}