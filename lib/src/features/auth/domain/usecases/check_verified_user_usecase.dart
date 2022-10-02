import 'package:dartz/dartz.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/features/auth/data/data_sources/auth_shared_prefs.dart';
import 'package:nft_deaa/src/features/auth/domain/repositories/auth_repository.dart';

class CheckVerifiedUserUseCase extends UseCase<bool, CheckVerifiedUserParams> {
  final AuthRepository repository;

  CheckVerifiedUserUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(CheckVerifiedUserParams checkVerifiedUserParams) async {
    final result = await repository.checkUserVerified(checkVerifiedUserParams.verificationCode, checkVerifiedUserParams.email);
    return result.fold((l) async {
      await sl<AuthSharedPrefs>().deleteUser();
      return Left(l);
    }, (r) async {
      await sl<AuthSharedPrefs>().deleteUser();
      return Right(r);
    });
  }
}

class CheckVerifiedUserParams {
  final String verificationCode;
  final String email;

  CheckVerifiedUserParams({required this.verificationCode, required this.email});
}
