import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:student/presentation/splash/bloc/splash_event.dart';
import 'package:student/presentation/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState>{

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  SplashBloc(): super(SplashInitial()){
    on<RenderSplash>((event, emit) async{
      User? user = auth.currentUser;

      if(user != null){
        final topicName = user.phoneNumber!.substring(1);
        debugPrint("Topic name: $topicName");
        firebaseMessaging.subscribeToTopic("student_${user.phoneNumber!.substring(1)}");
        emit(GoToRegister());
      }
      else{
        emit(GoToAuth());
      }
    });
  }
}