import 'package:get_it/get_it.dart';
import '../features/data/datasources/auth_datasources.dart';
import '../features/data/repositories_impl/auth_repositories_impl.dart';
import '../features/domain/repositories/auth_repository.dart';
import '../features/domain/usecases/auth/sign_in.dart';
import '../features/domain/usecases/auth/sign_up.dart';
import '../features/domain/usecases/auth/verify_otp.dart';
import '../features/domain/usecases/auth/logout.dart';
import '../features/domain/usecases/user/get_user.dart';
import '../features/presentation/provider/auth_provider.dart';
import '../features/data/datasources/sobi-goals_datasources.dart';
import '../features/data/repositories_impl/sobi-goals_repository_impl.dart';
import '../features/domain/repositories/sobi-goals_repository.dart';
import '../features/domain/usecases/sobi-goals/create_goals.dart';
import '../features/domain/usecases/sobi-goals/get_mission.dart';
import '../features/domain/usecases/sobi-goals/post_task_user.dart';
import '../features/domain/usecases/sobi-goals/get_summaries.dart';
import '../features/presentation/provider/sobi-goals_provider.dart';

final sl = GetIt.instance;

void setupDependencyInjection() {
  // Data source
  sl.registerLazySingleton<AuthDatasources>(() => AuthDatasources());

  // Repository: DAFTARKAN SEBAGAI AuthRepository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Usecases
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => SignUp(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));

  // Provider
  sl.registerFactory(
    () => AuthProvider(
      signInUsecase: sl(),
      signUpUsecase: sl(),
      verifyOtpUsecase: sl(),
      logoutUsecase: sl(),
      getUserUsecase: sl(),
    ),
  );

  // Sobi Goals
  sl.registerLazySingleton<SobiGoalsDatasource>(() => SobiGoalsDatasource());
  sl.registerLazySingleton<SobiGoalsRepository>(
    () => SobiGoalsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => CreateGoals(sl()));
  sl.registerLazySingleton(() => GetTodayMission(sl()));
  sl.registerLazySingleton(() => CompleteTask(sl()));
  sl.registerLazySingleton(() => GetSummaries(sl()));
  sl.registerFactory(
    () => SobiGoalsProvider(
      createGoalsUsecase: sl(),
      getTodayMissionUsecase: sl(),
      completeTaskUsecase: sl(),
      getSummariesUsecase: sl(),
      datasource: sl(),
    ),
  );
}
