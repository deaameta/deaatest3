import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../repositories/auth_repository.dart';

class ForgetPassword extends UseCase<bool, ForgetPasswordParams> {
  final AuthRepository repository;
  ForgetPassword(this.repository);

  @override
  Future<Either<Failure, bool>> call(ForgetPasswordParams params) async {
    final result = await repository.forgetPassword(email: params.email.trim());

    return result;
  }
}

class ForgetPasswordParams {
  final String email;

  ForgetPasswordParams({required this.email});
}
