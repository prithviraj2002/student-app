import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/domain/repo/auth_repo.dart';
import 'package:student/presentation/auth/bloc/auth_event.dart';
import 'package:student/presentation/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final AuthRepo authRepo = getIt<AuthRepo>();

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController smsCode = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? storedVerificationId;

  AuthBloc() : super(AuthInitial()){
    on<AuthSendOtp>((event, emit) async {
      emit(AuthLoading());
      try {
        await auth.verifyPhoneNumber(
          phoneNumber: "+91${event.phoneNumber}",
          forceResendingToken: event.resendToken,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            User? user = auth.currentUser;

            if (user != null) {
              // Step 2: If user exists, link the phone number to their current account
              try {
                await user.linkWithCredential(credential);
                debugPrint("Phone number linked to existing account");
              } catch (e) {
                debugPrint("Error linking phone number: $e");
              }
            } else {
              // Step 3: If no existing user, sign in with phone credential
              UserCredential userCredential = await auth.signInWithCredential(credential);
              debugPrint("User signed in with phone: ${userCredential.user?.uid}");
            }
          },
          verificationFailed: (FirebaseAuthException e) {
            add(AuthEventFailed());
          },
          codeSent: (String verificationId, int? resendToken) {
            storedVerificationId = verificationId;
            add(AuthEventCodeSent(verificationId: verificationId, resendToken: resendToken!));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            storedVerificationId = verificationId;
          },
        );
      } catch (e) {
        add(AuthEventFailed());
      }
    });

    on<AuthEventCodeSent>((event, emit){
      emit(AuthCodeSent(verificationId: event.verificationId, resendToken: event.resendToken));
    });

    on<AuthVerifyOtp>((event, emit) async {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId,
          smsCode: event.otp,
        );

        UserCredential userCred = await auth.signInWithCredential(credential);

        if (userCred.user != null) {
          String? token = await userCred.user!.getIdToken();
          if(token != null){
            String uid = userCred.user!.uid;

            String role = await getRole(uid);
            debugPrint("Role: $role");

            if(role.isEmpty){
              setRole(userCred.user!.uid);
              firebaseMessaging.subscribeToTopic("student_${userCred.user!.phoneNumber!.substring(1)}");
              add(AuthEventSuccess());
            }
            else if(role == 'scribe'){
              add(AuthEventFailed());
            }
            else if(role == 'student'){
              firebaseMessaging.subscribeToTopic("student_${userCred.user!.phoneNumber!.substring(1)}");
              add(AuthEventSuccess());
            }
          }
          else {
            add(AuthEventFailed());
          }
        } else {
          add(AuthEventFailed());
        }
      } catch (e) {
        add(AuthEventFailed());
      }
    });

    on<AuthEventSuccess>((event, emit){

      emit(AuthSuccess());
    });

    on<AuthEventFailed>((event, emit){
      emit(AuthFailed(errorMsg: "An error occurred!"));
    });

    on<AuthLogout>((event, emit){
      emit(AuthLoading());
      auth.signOut();
      emit(AuthLogoutSuccess());
    });
  }

  Future<void> setRole(String uid) async{
    try{
      await authRepo.setUserRole(uid);
    } catch(e){
      debugPrint("An error occurred while setting role: $e");
      throw Exception(e.toString());
    }
  }

  Future<String> getRole(String uid) async{
    String role = "";
    try{
      final data = await authRepo.getUserRole(uid);

      if(data != null){
        role = data['role'];
      }
      return role;
    } catch(e){
      debugPrint("An exception occurred while getting role: $e");
      return role;
    }
  }
}
