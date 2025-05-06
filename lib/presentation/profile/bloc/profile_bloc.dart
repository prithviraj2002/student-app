import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/domain/model/student_model/student_model.dart';
import 'package:student/domain/repo/profile_repo.dart';
import 'package:student/presentation/profile/bloc/profile_event.dart';
import 'package:student/presentation/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  FirebaseAuth auth = FirebaseAuth.instance;
  final ProfileRepo repo = getIt<ProfileRepo>();

  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  void setValues(StudentModel model){
    name.value = TextEditingValue(text: model.name);
    age.value = TextEditingValue(text: model.age.toString());
    email.value = TextEditingValue(text: model.email);
    city.value = TextEditingValue(text: model.city);
    address.value = TextEditingValue(text: model.address);
    pincode.value = TextEditingValue(text: model.pincode);
  }

  ProfileBloc(): super(ProfileInitial()){
    on<GetStudentData>((event, emit) async{
      emit(StudentDataLoadingState());

      try{
        StudentModel student = await repo.getStudentProfile();

        setValues(student);
        emit(StudentDataState(student: student));
      } catch(e){
        emit(StudentDataErrorState(errorMsg: e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async{
      emit(UpdateProfileLoading());
      try{
        await repo.updateStudentProfile(
            StudentModel(
                name: name.text,
                email: email.text,
                gender: event.gender,
                age: int.parse(age.text),
                address: address.text,
                city: city.text,
                pincode: pincode.text
            ).toJson()
        );

        emit(UpdateProfileDone());
      } catch(e){
        emit(UpdateProfileError(errorMsg: e.toString()));
      }
    });

    on<Logout>((event, emit) async{
      emit(LogoutProfileLoading());
      try{
        await logout();

        emit(LogoutProfileDone());
      } catch(e){
        emit(LogoutProfileError(errorMsg: e.toString()));
      }
    });
  }

  Future<void> logout() async{
    await auth.signOut();
  }

  Future<void> delFirebaseAccount() async{
    await auth.currentUser!.delete();
  }
}