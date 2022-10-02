import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nft_deaa/src/core/core.dart';

import '../../../../../main.dart';
import '../../../../core/data/entities/user.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'auth_shared_prefs.dart';

class AuthApi {
  static final Dio tokenDio = Dio(BaseOptions(
    responseType: ResponseType.json,
    baseUrl: sl<Dio>().options.baseUrl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "charset": "utf-8",
      "Accept-Charset": "utf-8",
    },
  ))
    ..interceptors.add(LoggerInterceptor(
      logger,
      request: true,
      requestBody: true,
      error: true,
      responseBody: true,
      responseHeader: false,
      requestHeader: true,
    ));

  /// Login method
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final result = (await sl<Dio>().post("login", data: {"email": email, "password": password})).data;
      if (result["body"]['user'] != null) {
        final user = User.fromJson(result["body"]['user']);
        String? token = result["body"]['auth_token'];
        user.token = token;
        if (user.token != null) {
          clearDioInterceptors();
          addTokenToHeader(
            token!,
          );
        }

        return Right(user);
      } else {
        return const Left(ServerFailure("Error in Login", null));
      }
    } on DioError catch (e) {
      throw ServerException(handleDioError(e), e.response?.statusCode);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  /// Signup method
  Future<Either<Failure, User>> signup(SignUpParams request) async {
    try {
      final result = (await sl<Dio>().post(
        "register",
        data: request.toJson(),
      ))
          .data;
      if (result["body"]['user'] != null) {
        // no TFA
        final user = User.fromJson(result["body"]['user']);

        String? token = result["body"]['auth_token'];
        user.token = token;
        if (user.token != null) {
          clearDioInterceptors();
          addTokenToHeader(
            token!,
          );
        }
        return Right(user);
      } else {
        return const Left(ServerFailure("Error in Login", null));
      }
    } on DioError catch (e) {
      throw ServerException(handleDioError(e), e.response?.statusCode);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  static addTokenToHeader(String accessToken) {
    sl<Dio>().interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options, r) {
          options.headers["Authorization"] = "Bearer " + accessToken.toString();

          return r.next(options);
        }, onError: (error, handler) async {
          try {
            if ((error.response?.statusCode != null) && (error.response?.statusCode) == 403 && !error.requestOptions.path.contains("login")) {
              sl<Dio>().lock();
              // dev.debugger();

              tokenDio.interceptors.add(InterceptorsWrapper(onError: (DioError error, r) async {
                if ((error.response!.statusCode) == 403) {
                  // public token expired and logged in
                  onUnexpectedError(handler, error);
                } else {
                  r.reject(error);
                }
              }));

              await refreshToken(anotherDio: tokenDio);

              await continueAndRepeatRequest(error, handler);
            } else {
              return handler.next(error);
            }
          } catch (e) {
            onUnexpectedError(handler, error);
          }
        }));
  }

  static Future<bool> refreshToken({Dio? anotherDio}) async {
    try {
      final result = anotherDio != null
          ? (await anotherDio.post(
              "refresh",
            ))
              .data
          : (await sl<Dio>().post(
              "refresh",
            ))
              .data;
      final token = result["body"]["auth_token"];
      clearDioInterceptors();
      addTokenToHeader(
        token,
      );
      sl<AuthSharedPrefs>().saveUserToken(token);
      sl<AuthSharedPrefs>().saveUser(result["body"]["user"]);
      return true;
    } on DioError catch (e) {
      throw ServerException(handleDioError(e), e.response?.statusCode);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  static clearDioInterceptors() {
    sl<Dio>().interceptors.clear();
    sl<Dio>().interceptors.add(LoggerInterceptor(
          logger,
          request: true,
          requestBody: true,
          error: true,
          responseBody: true,
          responseHeader: false,
          requestHeader: true,
        ));
  }

  static Future<void> onUnexpectedError(ErrorInterceptorHandler handler, error) async {
    sl<Dio>().unlock();
    sl<Dio>().clear();
    handler.reject(error);
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
    navigatorKey.currentState?.pushReplacementNamed("/login");
  }

  static Future<void> continueAndRepeatRequest(DioError error, ErrorInterceptorHandler handler) async {
    sl<Dio>().unlock();
    return await sl<Dio>().fetch(error.response!.requestOptions).then(
      (r) {
        handler.resolve(r);
      },
      onError: (e) {
        return handler.reject(e);
      },
    );
  }

  // forget Password
  Future<Either<Failure, bool>> forgetPassword({required String email}) async {
    try {
      final result = (await sl<Dio>().post("password/forget", data: {"email": email})).data;
      if (result["status"] == true) {
        return Right(result["status"]);
      } else {
        return const Left(ServerFailure("Error", null));
      }
    } on DioError catch (e) {
      throw ServerException(handleDioError(e), e.response?.statusCode);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  // code check
  Future<Either<Failure, bool>> codeCheck({required String email, required String code}) async {
    try {
      final result = (await sl<Dio>().post("password/code/check", data: {"email": email, "code": code})).data;
      if (result["status"] == true) {
        return Right(result["status"]);
      } else {
        return const Left(ServerFailure("Error", null));
      }
    } on DioError catch (e) {
      throw ServerException(handleDioError(e), e.response?.statusCode);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  // password change
  Future<Either<Failure, bool>> passwordChange({required String email, required String password, required String code}) async {
    try {
      final result = (await sl<Dio>().post("password/change", data: {"email": email, "code": code, "password": password})).data;
      if (result["status"] == true) {
        return Right(result["status"]);
      } else {
        return const Left(ServerFailure("Error", null));
      }
    } on DioError catch (e) {
      throw ServerException(handleDioError(e), e.response?.statusCode);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  // checkUserVerified
  Future<Either<Failure, bool>> checkUserVerified({required String verificationCode, required String email}) async {
    try {
      final result = (await sl<Dio>().post("verify", data: {"verification_string": verificationCode, "email": email})).statusCode;
      if (result == 200) {
        return Right(true);
      } else {
        return Right(false);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 || e.response?.statusCode == 400) {
        return Right(false);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  /// Delete account method
  Future<Either<Failure, bool>> deleteAccount() async {
    try {
      final result = (await sl<Dio>().delete(
        "profile/delete",
      ))
          .data;
      if (result["message"] != "Success" || result["message"] != "success") {
        return Right(true);
      } else {
        return const Left(ServerFailure("Error in delete account", null));
      }
    } on DioError catch (e) {
      throw ServerException(handleDioError(e), e.response?.statusCode);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
