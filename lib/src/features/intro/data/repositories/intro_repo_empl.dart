import 'package:dartz/dartz.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/features/intro/domain/entities/intro.dart';
import '../../domain/repositories/intro_repository.dart';
import '../data_sources/intro_api.dart';
import '../data_sources/intro_shared_prefs.dart';

class IntroRepositoryImpl extends IntroRepository {
  final IntroApi introApi;
  final IntroSharedPrefs introPrefs;

  IntroRepositoryImpl(this.introApi, this.introPrefs);

  @override
  Future<Either<Failure, IntroEntity>> getIntroInfo() async {
    try {
      final result = await introApi.getIntroInfo();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
