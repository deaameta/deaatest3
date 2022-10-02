import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft_deaa/src/features/auth/presentation/pages/login_page.dart';
import 'package:nft_deaa/src/features/auth/presentation/pages/signup_page.dart';
import 'package:nft_deaa/src/features/home/presentation/pages/home_page.dart';

class AppRouter {
  static String currentRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch (settings.name) {

      // case '/check-code':
      //   return CupertinoPageRoute(settings: RouteSettings(name: settings.name), builder: (_) => CheckCodePage(email: settings.arguments.toString()));
      //
      //
      // case '/term_and_conditions':
      //   return CupertinoPageRoute(settings: RouteSettings(name: settings.name), builder: (_) => const TermAndConditionsPage());

      case '/home':
        return CupertinoPageRoute(settings: RouteSettings(name: settings.name), builder: (_) => const HomePage());
      case '/signup':
        return CupertinoPageRoute(settings: RouteSettings(name: settings.name), builder: (_) => const SignupPage());
      case '/login':
        return CupertinoPageRoute(settings: RouteSettings(name: settings.name), builder: (_) => const LoginPage());

      // case '/basePage':
      //   return CupertinoPageRoute(settings: RouteSettings(name: settings.name), builder: (_) => const BasePage());

      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
