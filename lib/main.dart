
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/core/data/data_sources/app_shared_prefs.dart';
import 'package:nft_deaa/src/core/services/connectivity/connectivity_builder.dart';
import 'package:nft_deaa/src/core/translations/l10n.dart';
import 'package:nft_deaa/src/core/util/AppSnackBar.dart';
import 'package:nft_deaa/src/core/util/helper.dart';
import 'package:nft_deaa/src/core/util/log.dart';
import 'package:nft_deaa/src/features/auth/data/data_sources/auth_shared_prefs.dart';
import 'package:nft_deaa/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nft_deaa/src/features/intro/presentation/pages/splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  // Wakelock.enable();
  await initInjections();

  // Add token to header
  String token = sl<AuthSharedPrefs>().getUser().token!;
  sl<Dio>().options.headers.addAll({'Authorization': 'Bearer $token'});
  tz.initializeTimeZones();
  Log.allowVerbose = false;
  Log.allowDebug = true;
  BlocOverrides.runZoned(() {
    runApp(
      //   DevicePreview(
      //   builder: (context) =>
      const App(),
      //   enabled: !kReleaseMode,
      // )
    );
  }, blocObserver: SimpleBlocObserver());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class App extends StatefulWidget {
  // TODO PUT IN NOTIFIER
  static Map<String, bool> mainMedia = {
    "from_drawer": false,
    "from_home": false,
    "from_home_approved": false,
    "from_home_non": false,
  };

  static const String defaultLanguage = "en";

  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();

  static void setLocale(BuildContext context, String newLocale) {
    _AppState state = context.findAncestorStateOfType()!;
    state.setState(() {
      state.locale = Locale(newLocale);
    });
    sl<AppSharedPrefs>().setLang(newLocale);
    sl<Dio>().options.headers.addAll({'lang': newLocale});
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
final nestedNavigator = GlobalKey<NavigatorState>();

class _AppState extends State<App> with WidgetsBindingObserver {
  Locale locale = const Locale("en");
  String? deviceLanguageCode;
  final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    // sl<AppSharedPrefs>().setLang("en");

    // sl<AuthSharedPrefs>().deleteUser();
    WidgetsBinding.instance.addObserver(this);
    // deviceLanguageCode = Platform.localeName.split('_')[0];
    // final lang = sl<AppSharedPrefs>().getLang();
    if (mounted) {
      String newLocale = Helper.getLang();
      setState(() {
        locale = Locale(newLocale);
      });
      sl<Dio>().options.headers.addAll({'lang': newLocale});
    }

    // initFirebaseMessaging();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // User user = sl<AuthSharedPrefs>().getUser();
        // if((user.id ?? -1) != -1 && (user.token ?? "") == ""){
        //   context.loaderOverlay.show(widget: AppLoader());
        //   authBloc.add(CheckIfUserVerified(user.id!));
        // }
        // UniLinks.initLink(callBackOther: (){
        // }, callBackVerifi: (code,email){
        //   BlocProvider.of<AuthBloc>(navigatorKey.currentContext!).add(VerifiedUser(code,email));
        // });
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    authBloc.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool? isDark = sl<AppSharedPrefs>().getTheme() ?? false;
  final AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    ;
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(
            value: authBloc,
          ),
        ],
        child: BlocListener(
            bloc: authBloc,
            listener: (context, state) async {
              if (state is UserLoggedOut) {
                context.loaderOverlay.hide();
                navigatorKey.currentState?.popUntil((route) => route.isFirst);
                navigatorKey.currentState?.popUntil((route) => route.isFirst);

                navigatorKey.currentState?.pushReplacementNamed("/home");
                navigatorKey.currentState?.pushNamed("/login");
              } else if (state is AuthInitial) {
                context.loaderOverlay.hide();
                navigatorKey.currentState?.popUntil((route) => route.isFirst);
                navigatorKey.currentState?.pushReplacementNamed("/home");
                if (await sl<AuthSharedPrefs>().hasToken()) {
                } else if ((sl<AuthSharedPrefs>().getUser().id ?? -1) != -1) {
                  // navigatorKey.currentState?.pushNamed("/verify_email_page");
                  // context.loaderOverlay.show(widget: AppLoader());
                  // authBloc.add(CheckIfUserVerified(sl<AuthSharedPrefs>().getUser().id!));
                }
              } else if (state is AuthUserLoggedInState) {
                navigatorKey.currentState?.pushReplacementNamed("/home");
              } else if (state is AuthUserNotLoggedInState) {
                navigatorKey.currentState?.pushReplacementNamed("/home");
              } else if (state is VerifyEmailLoggedInState) {
                navigatorKey.currentState?.pushReplacementNamed("/home");
                // navigatorKey.currentState?.pushNamed("/verify_email_page");
                // context.loaderOverlay.show(widget: AppLoader());
                // authBloc.add(CheckIfUserVerified(sl<AuthSharedPrefs>().getUser().id!));
              } else if (state is CheckVerifiedError) {
                if (navigatorKey.currentContext != null) {
                  navigatorKey.currentContext!.loaderOverlay.hide();
                  WidgetsBinding.instance.addPostFrameCallback((_) => Helper.showSnackBar(
                      navigatorKey.currentContext!, S.of(navigatorKey.currentContext!).account_not_activated,
                      type: ToastType.error));
                }
                navigatorKey.currentState?.popUntil((route) => route.isFirst);
                navigatorKey.currentState?.pushReplacementNamed("/home");
                navigatorKey.currentState?.pushNamed("/login");
              } else if (state is VerifiedUserSuccess) {
                if (navigatorKey.currentContext != null) {
                  navigatorKey.currentContext!.loaderOverlay.hide();
                  WidgetsBinding.instance.addPostFrameCallback((_) => Helper.showSnackBar(
                      navigatorKey.currentContext!, S.of(navigatorKey.currentContext!).account_activated,
                      type: ToastType.success));
                }
                navigatorKey.currentState?.popUntil((route) => route.isFirst);
                navigatorKey.currentState?.pushReplacementNamed("/home");
                navigatorKey.currentState?.pushNamed("/login");
              } else if (state is VerifiedUserError) {
                if (navigatorKey.currentContext != null) {
                  navigatorKey.currentContext!.loaderOverlay.hide();
                  WidgetsBinding.instance.addPostFrameCallback((_) => Helper.showSnackBar(
                      navigatorKey.currentContext!, S.of(navigatorKey.currentContext!).account_not_activated,
                      type: ToastType.error));
                }
                navigatorKey.currentState?.popUntil((route) => route.isFirst);
                navigatorKey.currentState?.pushReplacementNamed("/home");
                navigatorKey.currentState?.pushNamed("/login");
              } else if (state is SuccessDeleteAccountState) {
                if (mounted) {
                  sl<AuthSharedPrefs>().deleteUser();
                  navigatorKey.currentState?.pushNamedAndRemoveUntil("/home", (route) => false);
                }
              } else if (state is ErrorDeleteAccountState) {
                AppSnackBar.show(context, S.of(context).error_delete_account, ToastType.error);
              }
              // else {
              //   navigatorKey.currentState?.pushReplacementNamed("/login");
              // }
              // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
              // }
            },
            child: Builder(
              builder: (BuildContext context) {
                return MaterialApp(
                  useInheritedMediaQuery: true,
                  title: 'Gol Staking',
                  scaffoldMessengerKey: snackbarKey,
                  onGenerateRoute: AppRouter.generateRoute,
                  theme: ThemeData(
                      brightness: Brightness.light,
                      primaryColor: AppColors.white,
                      scaffoldBackgroundColor: AppColors.white,
                      backgroundColor: AppColors.white),
                  debugShowCheckedModeBanner: false,
                  locale: locale,
                  localizationsDelegates: const [
                    S.delegate,
                    CountryLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    MonthYearPickerLocalizations.delegate,
                  ],
                  navigatorKey: navigatorKey,
                  supportedLocales: const [
                    Locale("ar"),
                    Locale("en"),
                  ],

                  builder: (con, child) {
                    SizeConfig().init(con);
                    isDark = sl<AppSharedPrefs>().getTheme() ?? false;
                    return LoaderOverlay(
                      child: ConnectivityBuilder(
                          connectedCallback: () {},
                          noInternetString: "noInternet",
                          tryAgainString: "tryAgain",
                          child: Directionality(textDirection: locale.languageCode != "ar" ? TextDirection.ltr : TextDirection.rtl, child: child!)),
                    );
                  },
                  // initialRoute: "/",
                  home: const SplashScreen(),
                );
              },
            )));
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print(event);
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print(transition);
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print(error);
    }
    super.onError(bloc, error, stackTrace);
  }
}
