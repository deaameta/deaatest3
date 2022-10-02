import 'package:nft_deaa/src/core/injections.dart';
import 'package:nft_deaa/src/features/intro/data/data_sources/intro_api.dart';
import 'package:nft_deaa/src/features/intro/data/repositories/intro_repo_empl.dart';
import 'package:nft_deaa/src/features/intro/domain/usecases/get_intro_info.dart';

import 'data/data_sources/intro_shared_prefs.dart';
import 'domain/repositories/intro_repository.dart';

initIntroInjections() async {
  sl.registerLazySingleton<IntroApi>(() => IntroApi());
  sl.registerLazySingleton<IntroSharedPrefs>(() => IntroSharedPrefs());
  sl.registerLazySingleton<IntroRepository>(() => IntroRepositoryImpl(sl(), sl()));
  sl.registerFactory<GetIntroInfoUseCase>(() => GetIntroInfoUseCase(sl()));

}
