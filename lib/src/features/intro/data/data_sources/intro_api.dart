import 'package:dio/dio.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/features/intro/domain/entities/intro.dart';


class IntroApi {
  Future<IntroEntity> getIntroInfo() async {
    try {
      // return IntroEntity(androidCurrent: "1.1.0", androidAccept: "1.0.0", iosCurrent: "1.1.0", iosAccept: "1.0.0");
      return IntroEntity.fromJson((await sl<Dio>().get(
        "version",
      ))
          .data['body']);
    } on DioError catch (e) {
      throw ServerException(handleDioError(e), e.response?.statusCode);
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}
