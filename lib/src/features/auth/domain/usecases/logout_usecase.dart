import 'package:dartz/dartz.dart';
import 'package:nft_deaa/src/core/core.dart';

import '../repositories/auth_repository.dart';

class LogoutUseCase extends UseCase<bool, LogoutParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(LogoutParams params) async {
    return await repository.logout();
  }
}

class LogoutParams {
  LogoutParams();
}
