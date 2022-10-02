import 'package:dartz/dartz.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/features/intro/domain/entities/intro.dart';

abstract class IntroRepository {
  Future<Either<Failure, IntroEntity>> getIntroInfo();
}
