import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/domain/model/student_model/student_model.dart';
import 'package:student/domain/repo/register_repo.dart';
import 'package:student/presentation/register/bloc/register_event.dart';
import 'package:student/presentation/register/bloc/register_state.dart';
import 'package:student/presentation/register/cubit/gender_cubit.dart';
import 'package:student/presentation/register/views/pages/common_page.dart';
import 'package:student/presentation/register/views/pages/gender_page.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final RegisterRepo repo = getIt<RegisterRepo>();
  final GenderCubit genderCubit = GenderCubit();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();

  List<Widget> pages = [];

  void generatePages(){
    pages = [
      CommonPage(
          title: AppStrings.enterName,
          controller: name
      ),
      CommonPage(
          title: AppStrings.enterEmail,
          controller: email
      ),
      CommonPage(
          title: AppStrings.enterAge,
          controller: age
      ),
      BlocProvider.value(
        value: genderCubit,
          child: GenderPage()
      ),
      CommonPage(
          title: AppStrings.enterAddress,
          controller: address
      ),
      CommonPage(
          title: AppStrings.enterCity,
          controller: city
      ),
      CommonPage(
          title: AppStrings.enterPincode,
          controller: pincode
      ),
    ];
  }

  RegisterBloc(): super(RegisterInitial()){
    on<CheckStudentProfile>((event, emit) async{
      emit(RegisterStudentLoading());
      try{

        final response = await repo.checkStudentProfile();

        if(response['exists']){
          emit(GoToHome());
        }
        else{
          emit(RegisterInitial());
        }
      } catch(e){
        debugPrint("An exception occurred while getting student profile");
        emit(RegisterInitial());
      }
    });

    on<RegisterStudent>((event, emit) async{
      emit(RegisterStudentLoading());

      try{
        final response = await repo.registerStudent(
            StudentModel(
                name: name.text,
                email: email.text,
                gender: genderCubit.state,
                age: int.parse(age.text),
                address: address.text,
                city: city.text,
                pincode: pincode.text
            )
        );

        if(response['id'] != null || response['id'].isNotEmpty){
          emit(RegisterStudentSuccess());
        }
        else{
          emit(RegisterStudentError(errorMsg: "Something went wrong"));
        }
      } catch(e){
        emit(RegisterStudentError(errorMsg: e.toString()));
      }
    });
  }

  void disposeTextControllers(){
    name.dispose();
    email.dispose();
    age.dispose();
    address.dispose();
    city.dispose();
    pincode.dispose();
  }
}