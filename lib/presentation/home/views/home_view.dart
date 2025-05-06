import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors/app_colors.dart';
import 'package:student/core/strings/app_strings.dart';
import 'package:student/presentation/board/bloc/board_bloc.dart';
import 'package:student/presentation/board/views/board_view.dart';
import 'package:student/presentation/create_scribe_req/bloc/create_scribe_req_bloc.dart';
import 'package:student/presentation/create_scribe_req/view/create_scribe_req_view.dart';
import 'package:student/presentation/home/cubit/tab_cubit.dart';
import 'package:student/presentation/profile/bloc/profile_bloc.dart';
import 'package:student/presentation/profile/bloc/profile_event.dart';
import 'package:student/presentation/profile/view/profile_view.dart';
import 'package:student/presentation/requests/bloc/req_bloc/req_bloc.dart';
import 'package:student/presentation/requests/views/requests_views.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TabCubit tabCubit;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    tabCubit = context.read<TabCubit>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TabCubit, int>(
        builder: (BuildContext ctx, int tab){
          if(tab == 0){
            return BlocProvider.value(
                value: context.read<RequestBloc>(),
                child: RequestsView()
            );
          }
          else if(tab == 1){
            return BlocProvider.value(
                value: context.read<BoardBloc>(),
                child: BoardView()
            );
          }
          else if(tab == 2){
            return BlocProvider.value(
                value: context.read<CreateScribeReqBloc>(),
                child: CreateScribeReqView()
            );
          }
          else if(tab == 3){
            return BlocProvider.value(
                value: context.read<ProfileBloc>(),
                child: ProfileView()
            );
          }
          else{
            return BlocProvider.value(
                value: context.read<ProfileBloc>()..add(GetStudentData()),
                child: ProfileView());
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<TabCubit, int>(
          builder: (BuildContext ctx, int page){
            return BottomNavigationBar(
              selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: Colors.grey,
                currentIndex: page,
                onTap: (int value){
                  tabCubit.setTab(value);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.people),
                      label: AppStrings.request
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.padding),
                      label: "Board"
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      label: AppStrings.createScribeReq
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: AppStrings.profile
                  ),
                ]
            );
          }
      ),
    );
  }
}
