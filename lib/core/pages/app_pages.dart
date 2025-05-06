import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/presentation/auth/bloc/auth_bloc.dart';
import 'package:student/presentation/auth/cubit/timer_cubit.dart';
import 'package:student/presentation/auth/views/phone_view.dart';
import 'package:student/presentation/board/bloc/board_bloc.dart';
import 'package:student/presentation/create_scribe_req/bloc/create_scribe_req_bloc.dart';
import 'package:student/presentation/create_scribe_req/cubit/lang_cubit.dart';
import 'package:student/presentation/home/cubit/tab_cubit.dart';
import 'package:student/presentation/home/views/home_view.dart';
import 'package:student/presentation/profile/bloc/profile_bloc.dart';
import 'package:student/presentation/register/bloc/register_bloc.dart';
import 'package:student/presentation/register/cubit/page_cubit.dart';
import 'package:student/presentation/register/views/register_view.dart';
import 'package:student/presentation/requests/bloc/req_bloc/req_bloc.dart';
import 'package:student/presentation/requests/bloc/req_bloc/req_events.dart';
import 'package:student/presentation/splash/bloc/splash_bloc.dart';
import 'package:student/presentation/splash/views/splash_view.dart';

import '../../presentation/profile/bloc/profile_event.dart' show GetStudentData;

class AppRoutes {
  static const String initial = '/splash';
  static const String phone = '/phone';
  static const String register = '/register';
  static const String home = '/home';
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.initial:
      (ctx) => BlocProvider(create: (ctx) => SplashBloc(), child: SplashView()),
  AppRoutes.phone:
      (ctx) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (ctx) => AuthBloc(),),
            BlocProvider(create: (ctx) => TimerCubit(),),
          ], child: PhoneView()
      ),
  AppRoutes.register:
      (ctx) =>
          MultiBlocProvider(
              providers: [
                BlocProvider(create: (ctx) => RegisterBloc(),),
                BlocProvider(create: (ctx) => PageCubit(),),
              ], child: RegisterView()
          ),
  AppRoutes.home:
      (ctx) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (ctx) => TabCubit(),),
            BlocProvider(create: (ctx) => RequestBloc()..add(GetScribeReq()),),
            BlocProvider(create: (ctx) => ProfileBloc()..add(GetStudentData()),),
            BlocProvider(create: (ctx) => CreateScribeReqBloc(),),
            BlocProvider(create: (ctx) => PageCubit(),),
            BlocProvider(create: (ctx) => LanguageCubit(),),
            BlocProvider(create: (ctx) => BoardBloc(),),
          ],
          child: HomeView()
      ),
};
