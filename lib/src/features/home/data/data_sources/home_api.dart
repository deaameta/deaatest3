import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nft_deaa/src/features/home/domain/entities/balance_info_model.dart';
import 'package:nft_deaa/src/features/home/domain/entities/transaction_statis_enum.dart';
import '../../../../core/core.dart';
class HomeApi {


  Future<Either<Failure, bool>> getInfo() async {
    try {
      final result = (await sl<Dio>().get("balance-info/golc",)).data;
      Map<String,dynamic>? body = result["body"];
      // BalanceInfoModel.fromJson(body)
        return  const Right(true);

    } on DioError catch (e) {
      throw ServerException(handleDioError(e),e.response?.statusCode);
    } catch (e) {
      throw ServerException(e.toString(),null);
    }
  }

}
