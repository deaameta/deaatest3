import 'package:dartz/dartz.dart';
import '../repositories/home_repository.dart';
import '../../../../core/core.dart';
class GetInfoUseCase extends UseCase<bool, TransactionsParams> {
  final  HomeRepository repository;
  GetInfoUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(TransactionsParams params) async {
    return await repository.getInfo();
  }
}

class TransactionsParams {

  TransactionsParams();
}
