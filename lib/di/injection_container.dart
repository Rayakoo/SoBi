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
}
