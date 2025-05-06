import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors/app_colors.dart';
import 'package:student/core/pages/app_pages.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/presentation/auth/bloc/auth_bloc.dart';
import 'package:student/presentation/auth/bloc/auth_event.dart';
import 'package:student/presentation/auth/bloc/auth_state.dart';
import 'package:student/presentation/auth/cubit/timer_cubit.dart';
import 'package:student/presentation/components/common_long_btn.dart';
import 'package:student/presentation/components/common_text_field.dart';

class OtpView extends StatefulWidget {
  final String verifId;
  const OtpView({required this.verifId, super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  late AuthBloc authBloc;
  late TimerCubit timer;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    authBloc = context.read<AuthBloc>();
    timer = context.read<TimerCubit>();
    timer.startTimer();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
          builder: (BuildContext ctx, AuthState state){
            if(state is AuthCodeSent){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.enterOtp, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                    const SizedBox(height: 12,),
                    CommonTextField(
                      controller: authBloc.smsCode,
                      hintText: AppStrings.enterOtp,
                      textInputType: TextInputType.number,
                      validator: (String? value){
                        if(value == null || value.isEmpty){
                          return 'Empty code';
                        }
                        else if(value.length != 6){
                          return 'Invalid code, must be 6 digits';
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 52,),
                    Center(
                      child: CommonLongButton(
                          text: AppStrings.next,
                          onTap: (){
                            authBloc.add(
                                AuthVerifyOtp(
                                    otp: authBloc.smsCode.text, verificationId: widget.verifId
                                ));
                          }
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppStrings.didNotReceiveOtp, style: TextStyle(fontSize: 16),),
                        const SizedBox(width: 4,),
                        BlocBuilder<TimerCubit, int>(
                            builder: (BuildContext ctx, int time){
                              return Row(
                                children: [
                                  time != 0 ? Text("$time seconds") : Container(),
                                  const SizedBox(width: 12,),
                                  InkWell(
                                      onTap: () {
                                        if(time == 0){
                                          authBloc.add(
                                              AuthSendOtp(
                                                  phoneNumber: authBloc.phoneNumber.text,
                                                  resendToken: state.resendToken
                                              )
                                          );
                                        }
                                      },
                                      child: Text(
                                        AppStrings.resend,
                                        style: TextStyle(
                                            color: time == 0 ? AppColors.primaryColor : Colors.grey,
                                            fontSize: 16),
                                      )
                                  )
                                ],
                              );
                            }
                        )
                      ],
                    )
                  ],
                ),
              );
            }
            else{
              return Container();
            }
          },
          listener: (BuildContext ctx, AuthState state){
            if(state is AuthSuccess){
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.register, (dynamic) => false);
            }
            else if(state is AuthFailed){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
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
            else if(state is AuthLogoutSuccess){
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.phone,
                      (dynamic) => false
              );
            }
          }
      ),
    );
  }
}
