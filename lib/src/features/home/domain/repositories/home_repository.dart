import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';

abstract class HomeRepository {
  Future<Either<Failure, bool>> getInfo();
}
