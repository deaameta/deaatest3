import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../repositories/auth_repository.dart';

class CodeCheck extends UseCase<bool, CodeCheckParams> {
  final AuthRepository repository;
  CodeCheck(this.repository);

  @override
  Future<Either<Failure, bool>> call(CodeCheckParams params) async {
    final result = await repository.codeCheck(email: params.email.trim(), code: params.code);

    return result;
  }
}

class CodeCheckParams {
  final String email;
  final String code;
  CodeCheckParams({required this.email, required this.code});
}
