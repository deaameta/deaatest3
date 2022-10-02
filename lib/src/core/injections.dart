import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nft_deaa/src/core/app_constants.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/core/data/data_sources/app_shared_prefs.dart';
import 'package:nft_deaa/src/features/auth/auth_injections.dart';
import 'package:nft_deaa/src/features/auth/data/data_sources/auth_shared_prefs.dart';
import 'package:nft_deaa/src/features/home/home_injections.dart';
import 'package:nft_deaa/src/features/intro/intro_injection.dart';
import '../../main.dart';
import '../features/auth/data/data_sources/auth_api.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initAuthInjections();
  await initCoreInjections();
  await initIntroInjections();
  await initHomeInjections();
}

Future<void> onUnexpectedError(ErrorInterceptorHandler handler, error) async {
  sl<AuthSharedPrefs>().deleteUser();

  handler.reject(error);
  navigatorKey.currentState?.pushReplacementNamed("/login");
}

Future<void> initCoreInjections() async {
  initRootLogger();

  sl.registerSingletonAsync<Dio>(() async {
    final dio = Dio(BaseOptions(
        baseUrl: ApiUrl,
        validateStatus: (s) {
          return s! < 300;
        },
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json', "charset": "utf-8", "Accept-Charset": "utf-8"},
        responseType: ResponseType.json));

    dio.interceptors.add(LoggerInterceptor(
      logger,
      request: true,
      requestBody: true,
      error: true,
      responseBody: true,
      responseHeader: false,
      requestHeader: true,
    ));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, r) {
      return r.next(options);
    }, onError: (error, handler) async {
      try {
        if ((error.response?.statusCode != null) && (error.response?.statusCode) == 403) {
          // onUnexpectedError(handler, error);
          // dev.debugger();

          AuthApi.tokenDio.interceptors.add((InterceptorsWrapper(onError: (DioError error, r) async {
            if ((error.response!.statusCode) == 403) {
              // public token expired and logged in
              onUnexpectedError(handler, error);
            } else {
              r.reject(error);
            }
          })));

          await AuthApi.refreshToken(anotherDio: AuthApi.tokenDio);

          await AuthApi.continueAndRepeatRequest(error, handler);
        } else {
          return handler.next(error);
        }
      } catch (e) {
        onUnexpectedError(handler, error);
      }
    }));

    return dio;
  });
  await sl.isReady<Dio>();
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();

  sl.registerLazySingleton<AppSharedPrefs>(() => AppSharedPrefs(sl()));
}
