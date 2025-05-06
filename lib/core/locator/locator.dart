import 'package:get_it/get_it.dart';
import 'package:student/data/client/student_client.dart';
import 'package:student/data/db/student_api_service.dart';
import 'package:student/domain/repo/auth_repo.dart';
import 'package:student/domain/repo/home_repo.dart';
import 'package:student/domain/repo/profile_repo.dart';
import 'package:student/domain/repo/register_repo.dart';
import 'package:student/domain/repo/request_repo.dart';
import 'package:student/domain/repo/scribe_repo.dart';

final getIt = GetIt.instance;

void setupLocator(){
  getIt.registerSingleton(StudentClient());
  getIt.registerSingleton(StudentApiService());

  getIt.registerSingleton(AuthRepo());

  getIt.registerSingleton(HomeRepo());

  getIt.registerSingleton(RegisterRepo());

  getIt.registerSingleton(ProfileRepo());
  getIt.registerSingleton(ScribeRepo());
  getIt.registerSingleton(RequestRepo());
}

