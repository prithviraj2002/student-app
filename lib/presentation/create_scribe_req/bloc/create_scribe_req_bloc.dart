import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/domain/model/scribe_req_model/scribe_req_model.dart';
import 'package:student/domain/model/student_model/language_model.dart';
import 'package:student/domain/repo/scribe_repo.dart';
import 'package:student/presentation/create_scribe_req/bloc/create_scribe_req_event.dart';
import 'package:student/presentation/create_scribe_req/bloc/create_scribe_req_state.dart';
import 'package:student/presentation/create_scribe_req/components/date_page.dart';
import 'package:student/presentation/create_scribe_req/components/lang_page.dart';
import 'package:student/presentation/create_scribe_req/components/time_page.dart';
import 'package:student/presentation/create_scribe_req/cubit/lang_cubit.dart';
import 'package:student/presentation/register/views/pages/common_page.dart';

class CreateScribeReqBloc extends Bloc<CreateScribeReqEvent, CreateScribeReqState>{
  FirebaseAuth auth = FirebaseAuth.instance;

  LanguageCubit languageCubit = LanguageCubit();
  ScribeRepo repo = getIt<ScribeRepo>();

  TextEditingController examName = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController board = TextEditingController();

  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();

  List<Widget> pages = [];

  void generatePages(){
    pages = [
      CommonPage(
          title: AppStrings.enterExamName,
          controller: examName
      ),
      CommonPage(
          title: AppStrings.enterSubject,
          controller: subject
      ),
      CommonPage(
          title: AppStrings.enterDuration,
          controller: duration
      ),
      BlocProvider.value(
          value: languageCubit,
          child: LangPage()
      ),
      DatePage(
          title: AppStrings.enterDate,
          controller: date,
      ),
      TimePage(
          title: AppStrings.enterTime,
          controller: time
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
      CommonPage(
          title: AppStrings.enterBoard,
          controller: board
      ),
    ];
  }

  CreateScribeReqBloc(): super(InitialCreateScribeReq()){
    on<CreateScribeReq>((event, emit) async{
      emit(CreateScribeReqLoading());
      try{
        await repo.createScribeReq(
            ScribeRequest(
                examName: examName.text,
                subject: subject.text,
                language: getStringFromLanguage(languageCubit.state.first),
                date: date.text,
                time: time.text,
                duration: int.parse(duration.text),
                address: address.text,
                city: city.text,
                pincode: pincode.text,
                board: board.text,
                modeOfExam: "Pen Paper",
                studentId: auth.currentUser!.phoneNumber!,
              id: ''
            ).toJson()
        );

        emit(CreateScribeReqDone());
        // Future.delayed(Duration(seconds: 5), () {
        //   emit(InitialCreateScribeReq());
        // });
      } catch(e){
        emit(CreateScribeReqError(errorMsg: e.toString()));
      }
    });

    on<ResetScribeCreation>((event, emit){
      emit(InitialCreateScribeReq());
    });
  }
}