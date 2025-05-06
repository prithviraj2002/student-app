import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/domain/model/student_model/gender_model.dart';

class GenderCubit extends Cubit<Gender>{
  GenderCubit(): super(Gender.female);

  void selectGender(Gender g){
    emit(g);
  }
}