import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../repositories/auth_repository.dart';

class PasswordChange extends UseCase<bool, PasswordChangeParams> {
  final AuthRepository repository;
  PasswordChange(this.repository);

  @override
  Future<Either<Failure, bool>> call(PasswordChangeParams params) async {
    final result = await repository.passwordChange(email: params.email.trim(), code: params.code, password: params.password);

    return result;
  }
}

class PasswordChangeParams {
  final String email;
  final String password;
  final String code;
  PasswordChangeParams({required this.email, required this.password, required this.code});
}
