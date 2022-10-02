import 'package:dartz/dartz.dart';
import 'package:nft_deaa/src/core/data/entities/user.dart';

import '../../../../core/core.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../data_sources/auth_api.dart';
import '../data_sources/auth_shared_prefs.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApi authApi;
  final AuthSharedPrefs authPrefs;

  AuthRepositoryImpl(this.authApi, this.authPrefs);

  @override
  Future<Either<Failure, User>> emailConfirmationCode({required String email, required String verificationCode}) {
    // TODO: implement emailConfirmationCode
    throw UnimplementedError();
  }

  /// Login method
  @override
  Future<Either<Failure, User>> login({required String email, required String password}) async {
    try {
      final result = await authApi.login(email, password);
      return result.fold((l) {
        //Tfa
        return Left(ServerFailure(l.errorMessage, null));
      }, (r) {
        authPrefs.saveUser(r);
        return Right(r);
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  /// Signup method
  @override
  Future<Either<Failure, User>> signup(SignUpParams request) async {
    try {
      final result = await authApi.signup(request);
      return result.fold((l) {
        return Left(ServerFailure(l.errorMessage, null));
      }, (r) {
        authPrefs.saveUser(r);
        return Right(r);
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await authPrefs.logout();
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> forgetPassword({required String email}) async {
    try {
      final result = await authApi.forgetPassword(email: email);
      return result.fold((l) {
        return Left(ServerFailure(l.errorMessage, null));
      }, (r) {
        return Right(r);
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> codeCheck({required String email, required String code}) async {
    try {
      final result = await authApi.codeCheck(email: email, code: code);
      return result.fold((l) {
        return Left(ServerFailure(l.errorMessage, null));
      }, (r) {
        return Right(r);
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> passwordChange({required String email, required String password, required String code}) async {
    try {
      final result = await authApi.passwordChange(email: email, password: password, code: code);
      return result.fold((l) {
        return Left(ServerFailure(l.errorMessage, null));
      }, (r) {
        return Right(r);
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> checkUserVerified(String verificationCode, String email) async {
    try {
      final result = await authApi.checkUserVerified(verificationCode: verificationCode, email: email);
      return result.fold((l) {
        return Left(ServerFailure(l.errorMessage, null));
      }, (r) {
        return Right(r);
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      final result = await authApi.deleteAccount();
      return result.fold((l) {
        return Left(ServerFailure(l.errorMessage, null));
      }, (r) {
        return const Right("");
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
