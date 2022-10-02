
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/features/home/data/data_sources/home_api.dart';
import 'package:nft_deaa/src/features/home/data/data_sources/home_shared_prefs.dart';
import 'package:nft_deaa/src/features/home/data/repositories/home_repo_empl.dart';
import 'package:nft_deaa/src/features/home/domain/repositories/home_repository.dart';
import 'package:nft_deaa/src/features/home/domain/usecases/get_info_usecase.dart'; 

initHomeInjections() {
  sl.registerLazySingleton<HomeApi>(() => HomeApi());
  sl.registerLazySingleton<HomeSharedPrefs>(() => HomeSharedPrefs(sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        sl(),
      ));
  sl.registerFactory<GetInfoUseCase>(() => GetInfoUseCase(sl()));
}
