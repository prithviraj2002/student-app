import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors/app_colors.dart';
import 'package:student/core/pages/app_pages.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:student/presentation/splash/bloc/splash_event.dart';
import 'package:student/presentation/splash/bloc/splash_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashBloc splashBloc;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    splashBloc = context.read<SplashBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (BuildContext ctx, SplashState state){
        if(state is GoToAuth){
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.phone, (dynamic) => false);
        }
        else if(state is GoToRegister){
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.register, (dynamic) => false);
        }
      },
      child: Scaffold(
        body: Center(
            child: Animate(
              effects: [
                FadeEffect(duration: const Duration(seconds: 5))
              ],
              onComplete: (AnimationController c) {
                if(c.isCompleted){
                  context.read<SplashBloc>().add(RenderSplash());
                }
              },
              child: Text(
                AppStrings.scribeTribe,
                style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 36),
              ),
            )
        ),
      ),
    );
  }
}
