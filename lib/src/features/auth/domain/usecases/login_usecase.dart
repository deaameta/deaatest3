import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../../../core/data/entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase extends UseCase<User, LoginParams> {
  final  AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    final result = await repository.login(email: params.email.trim(), password: params.password.trim());
  return  result.fold((l) {
      return Left(l);
    }, (r) async {
     return Right(r);
    });
  }

}
class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}