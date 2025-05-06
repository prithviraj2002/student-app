import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors/app_colors.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/presentation/auth/bloc/auth_bloc.dart';
import 'package:student/presentation/auth/bloc/auth_event.dart';
import 'package:student/presentation/auth/bloc/auth_state.dart';
import 'package:student/presentation/auth/cubit/timer_cubit.dart';
import 'package:student/presentation/auth/views/otp_view.dart';
import 'package:student/presentation/components/common_text_field.dart';

class PhoneView extends StatefulWidget {
  const PhoneView({super.key});

  @override
  State<PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  late AuthBloc authBloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    authBloc = context.read<AuthBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext ctx, AuthState state){
          if(state is AuthCodeSent){
            Navigator.push(
              ctx,
              MaterialPageRoute(
                  builder: (ctx) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                            value: authBloc
                        ),
                        BlocProvider.value(value: context.read<TimerCubit>())
                      ],
                      child: OtpView(verifId: state.verificationId)
                  )
              ),
            );
          }
          else if(state is AuthLoading){
            showDialog(
                context: context,
                builder: (ctx) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
            );
          }
        },
        builder: (BuildContext context, AuthState state) {
          return Form(
            key: authBloc.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(AppStrings.enterPhoneNumber, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 24,),
                  CommonTextField(
                    controller: authBloc.phoneNumber,
                    hintText: AppStrings.enterPhoneNumber,
                    textInputType: TextInputType.phone,
                    validator: (String? value){
                      if(value == null || value.isEmpty){
                        return "Empty phone number";
                      }
                      else if(value.length != 10){
                        return "Enter valid number";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 24,),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          if(authBloc.formKey.currentState!.validate() && authBloc.phoneNumber.text.isNotEmpty){
                            authBloc.add(AuthSendOtp(phoneNumber: authBloc.phoneNumber.text));
                          }
                        },
                        child: Text(AppStrings.sendOtp, style: TextStyle(color: AppColors.primaryColor, fontSize: 24, fontWeight: FontWeight.bold),)
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
