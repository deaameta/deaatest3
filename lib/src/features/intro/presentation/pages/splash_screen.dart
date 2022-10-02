import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:launch_review/launch_review.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/core/presentation/widgets/background_image_widget.dart';
import 'package:nft_deaa/src/core/util/AppSnackBar.dart';
import 'package:nft_deaa/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nft_deaa/src/features/intro/domain/usecases/get_intro_info.dart';
import 'package:nft_deaa/src/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final IntroBloc _introBloc = IntroBloc(sl());

  @override
  void initState() {
    _introBloc.add(GetDataEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool isAnimatedWidth = false;
  int endTrigger = 0;
  bool isAnimatedHeight = false;

  static bool isGetVersion = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundImageWidget(
      child: Center(
          // child: Lottie.asset(
          //   'assets/logos.json',
          //   // width: SizeConfig.w(200),
          //   // height: SizeConfig.w(200),
          //   alignment: Alignment.center,
          //   fit: BoxFit.cover,
          // ),
          child: BlocConsumer(
              bloc: _introBloc,
              listener: (context, state) {
                if (state is IntroFailureState) {
                  AppSnackBar.show(context, state.message, ToastType.error);
                  return;
                } else if (state is IntroSuccessState) {
                  if (state.introAction.type == TypeUpdateVersion.acceptable) {
                    isGetVersion = true;
                    process();
                  } else if (state.introAction.type == TypeUpdateVersion.updateAvailable) {
                    showUpdateAvailable(state.introAction.autoUpdate);
                  } else if (state.introAction.type == TypeUpdateVersion.updateMendatory) {
                    showNeedUpdate(state.introAction.autoUpdate);
                  }
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/svg_images/logo.svg",
                        alignment: Alignment.center,
                        color: AppColors.primaryColor,
                        fit: BoxFit.cover,
                        width: SizeConfig.w(200),
                        height: SizeConfig.w(200),
                      ),
                    ),
                  ],
                );
              })),
    ));
  }

  void process() {
    // if (
    // isLoadedLottiFile &&
    //     isClickProcess){
    if (isGetVersion) BlocProvider.of<AuthBloc>(context).add(CheckIfLoggedEvent());
    // }
  }

  Future showUpdateAvailable(bool isAutoUpdate) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("New version available"),
            content: const Text("Update the application to stay up to date with latest features"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    isGetVersion = true;
                    process();
                  },
                  child: const Text("Remind me later")),
              TextButton(
                  onPressed: () async {
                    openStore(isAutoUpdate);
                  },
                  child: const Text("Update"))
            ],
          );
        });
  }

  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  Future<void> checkForUpdate() async {
    await InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
        // print("infoinfo");
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  Future showNeedUpdate(bool isAutoUpdate) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("App Version is too old"),
            content: const Text("Update the application to stay up to date with latest features"),
            actions: [
              TextButton(
                  onPressed: () {
                    openStore(isAutoUpdate);
                  },
                  child: const Text("Update"))
            ],
          );
        });
  }

  void openStore(bool isAutoUpdate) async {
    bool isIos = Platform.isIOS;
    if (isIos) {
      // TODO Please change ID
      // LaunchReview.launch(iOSAppId: "");
      LaunchReview.launch(iOSAppId: "1630955462");
    } else {
      if (await DeviceApps.isAppInstalled('com.android.vending')) {
        if (isAutoUpdate) {
          await checkForUpdate();
          if (_updateInfo != null) {
            if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
              InAppUpdate.performImmediateUpdate().catchError((e) {
                LaunchReview.launch();
              });
            } else {
              LaunchReview.launch();
            }
          } else {
            LaunchReview.launch();
          }
        } else {
          LaunchReview.launch();
        }
      } else if (await DeviceApps.isAppInstalled('com.huawei.appmarket')) {
        await launchUrl(
          Uri.parse("appmarket://details?id=com.metagols.nft"),
          mode: LaunchMode.externalApplication,
        ).catchError((e) async {
          await launchUrl(
            Uri.parse("https://play.google.com/store/apps/details?id=com.metagols.nft"),
            mode: LaunchMode.inAppWebView,
          );
        });
      } else {
        await launchUrl(
          Uri.parse("https://play.google.com/store/apps/details?id=com.metagols.nft"),
          mode: LaunchMode.inAppWebView,
        );
      }
    }
  }
}
