import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:nft_deaa/src/core/core.dart';

import '../repositories/intro_repository.dart';

class GetIntroInfoUseCase extends UseCase<IntroAction, NoParams> {
  final IntroRepository repository;

  GetIntroInfoUseCase(this.repository);

  @override
  Future<Either<Failure, IntroAction>> call(NoParams params) async {
    return Right(IntroAction(type: TypeUpdateVersion.acceptable, autoUpdate: true));

    var packageInfo = await PackageInfo.fromPlatform();

    String appVersion = packageInfo.version;
    final result = await repository.getIntroInfo();
    bool isIos = Platform.isIOS;
    int v1Number = getExtendedVersionNumber(appVersion);
    return result.fold((l) {
      return Left(l);
    }, (r) {
      if (isIos) {
        int v2CurrentIOS = getExtendedVersionNumber(r.currentIos);
        int v2AcceptIOS = getExtendedVersionNumber(r.acceptIos);

        if (v1Number >= v2CurrentIOS) {
          return Right(IntroAction(type: TypeUpdateVersion.acceptable, autoUpdate: r.autoUpdate ?? false));
        } else if (v1Number >= v2AcceptIOS) {
          return Right(IntroAction(type: TypeUpdateVersion.updateAvailable, autoUpdate: r.autoUpdate ?? false));
        } else {
          return Right(IntroAction(type: TypeUpdateVersion.updateMendatory, autoUpdate: r.autoUpdate ?? false));
        }
      } else {
        int v2CurrentAndroid = getExtendedVersionNumber(r.currentAndroid);
        int v2AcceptAndroid = getExtendedVersionNumber(r.acceptAndroid);

        // android
        if (v1Number >= v2CurrentAndroid) {
          return Right(IntroAction(type: TypeUpdateVersion.acceptable, autoUpdate: r.autoUpdate ?? false));
        } else if (v1Number >= v2AcceptAndroid) {
          return Right(IntroAction(type: TypeUpdateVersion.updateAvailable, autoUpdate: r.autoUpdate ?? false));
        } else {
          return Right(IntroAction(type: TypeUpdateVersion.updateMendatory, autoUpdate: r.autoUpdate ?? false));
        }
      }
    });
  }

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }
}

class IntroAction {
  final TypeUpdateVersion type;
  final bool autoUpdate;

  IntroAction({required this.type, required this.autoUpdate});
}

enum TypeUpdateVersion { acceptable, updateAvailable, updateMendatory }
