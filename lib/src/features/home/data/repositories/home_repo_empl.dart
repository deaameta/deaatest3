import 'dart:ffi';

import 'package:dartz/dartz.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_api.dart';
import '../../../../core/core.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeApi homeApi;
  // final HomeSharedPrefs homePrefs;
  HomeRepositoryImpl(this.homeApi
      // , this.homePrefs
      );


  @override
  Future<Either<Failure, bool>> getInfo() async {
    try {
      final result = await homeApi.getInfo();
      return result.fold((l) {
        //Tfa
        return Left(ServerFailure(l.errorMessage, null));
      }, (r) {
        return Right(r);
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

}
