import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors/app_colors.dart';
import 'package:student/core/pages/app_pages.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/presentation/components/common_error_widget.dart';
import 'package:student/presentation/components/common_long_btn.dart';
import 'package:student/presentation/register/bloc/register_bloc.dart';
import 'package:student/presentation/register/bloc/register_event.dart';
import 'package:student/presentation/register/bloc/register_state.dart';
import 'package:student/presentation/register/cubit/page_cubit.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late RegisterBloc registerBloc;
  late PageCubit pageCubit;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    registerBloc = context.read<RegisterBloc>();
    pageCubit = context.read<PageCubit>();
    registerBloc.add(CheckStudentProfile());
    registerBloc.generatePages();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    registerBloc.disposeTextControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterBloc, RegisterState>(
          builder: (BuildContext ctx, RegisterState state){
            if(state is RegisterInitial){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Column(
                  children: [
                    Expanded(child: Container()),
                    Text(AppStrings.scribeTribe, style: TextStyle(color: AppColors.primaryColor, fontSize: 28, fontWeight: FontWeight.bold),),
                    Expanded(child: Container()),
                    BlocBuilder<PageCubit, int>(
                      builder: (BuildContext ctx, int page){
                        return registerBloc.pages[page];
                      }),
                      Expanded(child: Container()),
                      CommonLongButton(
                          text: AppStrings.next,
                          onTap: () {
                            if(pageCubit.state < 6){
                              pageCubit.increment();
                            }
                            else{
                              registerBloc.add(RegisterStudent());
                            }
                          }
                      ),
                      Expanded(child: Container()),
                  ],
                ),
              );
            }
            else if(state is RegisterStudentError){
              return CommonErrorWidget();
            }
            else if(state is RegisterStudentLoading){
              return const Center(child: CircularProgressIndicator());
            }
            else{
              return Container();
            }
          },
          listener: (BuildContext ctx, RegisterState state){
            if(state is RegisterStudentError){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong!")));
            }
            else if(state is RegisterStudentSuccess){
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (dynamic) => false);
            }
            else if(state is GoToHome){
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (dynamic) => false);
            }
          }
      ),
    );
  }
}
