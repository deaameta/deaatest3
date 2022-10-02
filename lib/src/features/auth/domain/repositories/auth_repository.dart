import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../../core/data/entities/user.dart';
import '../usecases/signup_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({required String email, required String password});
  Future<Either<Failure, User>> signup(SignUpParams signUpRequestModel);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, User>> emailConfirmationCode({required String email, required String verificationCode});
  Future<Either<Failure, bool>> forgetPassword({required String email});
  Future<Either<Failure, bool>> codeCheck({required String email, required String code});
  Future<Either<Failure, bool>> passwordChange({required String email, required String password, required String code});
  Future<Either<Failure, bool>> checkUserVerified(String verificationCode,String email);
  Future<Either<Failure, void>> deleteAccount();

}
