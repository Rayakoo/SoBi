import 'package:get_it/get_it.dart';
import 'package:sobi/features/domain/usecases/sobi-goals/post_summaries.dart';
import 'package:sobi/features/domain/usecases/user/update_user.dart';
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
import '../features/data/datasources/education_datasource.dart';
import '../features/data/repositories_impl/education_repository_impl.dart';
import '../features/domain/repositories/education_repository.dart';
import '../features/domain/usecases/education/get_educations.dart';
import '../features/domain/usecases/education/get_education_detail.dart';
import '../features/domain/usecases/education/get_education_history.dart';
import '../features/presentation/provider/education_provider.dart';
import '../features/data/datasources/sobi-quran_datasources.dart';
import '../features/data/repositories_impl/sobi-quran_repository_impl.dart';
import '../features/domain/repositories/sobi-quran_repository.dart';
import '../features/domain/usecases/sobi-quran/get_surat.dart';
import '../features/domain/usecases/sobi-quran/get_surat_detail.dart';
import '../features/domain/usecases/sobi-quran/get_tafsir.dart';
import '../features/presentation/provider/sobi-quran_provider.dart';

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
  sl.registerLazySingleton(() => UpdateUser(sl())); // <--- Tambahkan ini

  // Provider
  sl.registerFactory(
    () => AuthProvider(
      signInUsecase: sl(),
      signUpUsecase: sl(),
      verifyOtpUsecase: sl(),
      logoutUsecase: sl(),
      getUserUsecase: sl(),
      updateUserUsecase: sl(), // <--- Pastikan ini ada
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
  sl.registerLazySingleton(() => PostSummaries(sl()));
  sl.registerFactory(
    () => SobiGoalsProvider(
      createGoalsUsecase: sl(),
      getTodayMissionUsecase: sl(),
      completeTaskUsecase: sl(),
      getSummariesUsecase: sl(),
      postSummariesUsecase: sl(),
      datasource: sl(),
    ),
  );

  // Education
  sl.registerLazySingleton<EducationDatasource>(() => EducationDatasource());
  sl.registerLazySingleton<EducationRepository>(
    () => EducationRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetEducations(sl()));
  sl.registerLazySingleton(() => GetEducationDetail(sl()));
  sl.registerLazySingleton(() => GetEducationHistory(sl()));
  sl.registerFactory(
    () => EducationProvider(
      getEducationsUsecase: sl(),
      getEducationDetailUsecase: sl(),
      getEducationHistoryUsecase: sl(), // tambahkan ini
    ),
  );

  // Sobi Quran
  sl.registerLazySingleton<SobiQuranDatasource>(() => SobiQuranDatasource());
  sl.registerLazySingleton<SobiQuranRepository>(
    () => SobiQuranRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetSurat(sl()));
  sl.registerLazySingleton(() => GetSuratDetail(sl()));
  sl.registerLazySingleton(() => GetTafsir(sl()));
  sl.registerFactory(
    () => SobiQuranProvider(
      getSuratUsecase: sl(),
      getSuratDetailUsecase: sl(),
      getTafsirUsecase: sl(),
    ),
  );
}
