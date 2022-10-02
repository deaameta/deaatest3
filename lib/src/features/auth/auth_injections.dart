import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/features/auth/data/data_sources/auth_api.dart';
import 'package:nft_deaa/src/features/auth/data/data_sources/auth_shared_prefs.dart';
import 'package:nft_deaa/src/features/auth/data/repositories/auth_repo_empl.dart';
import 'package:nft_deaa/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/check_verified_user_usecase.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/code_check.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/forget_password.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/password_change.dart';
import 'package:nft_deaa/src/features/auth/domain/usecases/signup_usecase.dart';

initAuthInjections() {
  sl.registerLazySingleton<AuthApi>(() => AuthApi());
  sl.registerFactory<AuthSharedPrefs>(() => AuthSharedPrefs(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  sl.registerFactory<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerFactory<SignupUseCase>(() => SignupUseCase(sl()));
  sl.registerFactory<LogoutUseCase>(() => LogoutUseCase(sl()));
  sl.registerFactory<DeleteAccountUseCase>(() => DeleteAccountUseCase(sl()));
  sl.registerFactory<CheckVerifiedUserUseCase>(() => CheckVerifiedUserUseCase(sl()));
  sl.registerFactory<PasswordChange>(() => PasswordChange(sl()));
  sl.registerFactory<ForgetPassword>(() => ForgetPassword(sl()));
  sl.registerFactory<CodeCheck>(() => CodeCheck(sl()));
}
