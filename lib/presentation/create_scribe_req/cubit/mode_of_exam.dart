import 'package:bloc/bloc.dart';

enum ExamMode{
  CBT,
  PenPaper
}

String getStringFromExamModel(ExamMode mode){
  if(mode == ExamMode.CBT){
    return 'Computer-Based-Test';
  }
  else{
    return 'Pen & Paper Test';
  }
}

ExamMode getExamModeFromString(String mode){
  if(mode == 'CBT' || mode == 'cbt' || mode == 'Computer-Based-Test' || mode == 'computer-based-test'){
    return ExamMode.CBT;
  }
  else{
    return ExamMode.PenPaper;
  }
}

class ExamModeCubit extends Cubit<ExamMode>{
  ExamModeCubit(): super(ExamMode.CBT);

  void selectMode(ExamMode mode){
    emit(mode);
  }
}
