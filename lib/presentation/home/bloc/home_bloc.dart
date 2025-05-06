import 'package:bloc/bloc.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/domain/repo/home_repo.dart';
import 'package:student/presentation/home/bloc/home_event.dart';
import 'package:student/presentation/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  final HomeRepo repo = getIt<HomeRepo>();

  HomeBloc(): super(HomeInitial()){

  }
}