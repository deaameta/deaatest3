import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../../../core/data/entities/user.dart';
import '../repositories/auth_repository.dart';

class DeleteAccountUseCase extends UseCase<void, DeleteAccountParams> {
  final  AuthRepository repository;
  DeleteAccountUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteAccountParams params) async {
    final result = await repository.deleteAccount();
  return  result.fold((l) {
      return Left(l);
    }, (r) async {
     return Right(r);
    });
  }

}
class DeleteAccountParams {

}