import 'dart:async';

import 'package:uni_links/uni_links.dart';

class UniLinks {
  static bool didInitiLinks = false;

  // static void initLink({required Function callBackOther, Function(String,String)? callBackVerifi = null}) async {
  //
  //   _handleInitialUri(callBackOther:callBackOther,callBackVerifi: callBackVerifi,);
  //    _sub =  uriLinkStream.listen((Uri? initialUri) {
  //     if (initialUri != null) {
  //       if (initialUri.toString().contains("verification_string")) {
  //         if (callBackVerifi != null) {
  //           if (navigatorKey.currentContext != null && (!navigatorKey.currentContext!.loaderOverlay.visible) && ModalRoute.of(navigatorKey.currentContext!)?.settings.name == "/verify_email_page"){
  //             navigatorKey.currentContext!.loaderOverlay.show(widget: AppLoader());
  //           }
  //           callBackVerifi(initialUri.queryParameters['verification_string'].toString(),initialUri.queryParameters['email'].toString());
  //           _sub?.cancel();
  //           _sub = null;
  //           return ;
  //         }
  //       }
  //     }
  //     callBackOther();
  //   }, onError: (Object err) {
  //     callBackOther();
  //   });
  //
  // }

  static Future<void> initLink({required Function(String, String) callBackVerifi,required Function(String, String) callBackChangePassword}) async {
    if (!didInitiLinks) {
      didInitiLinks = true;
      try {
        final initialUri = await getInitialUri();
        if (initialUri != null) {
          if (initialUri.toString().contains("change-password")) {
              // if (navigatorKey.currentContext != null && !navigatorKey.currentContext!.loaderOverlay.visible) {
              //   navigatorKey.currentContext!.loaderOverlay.show(widget: AppLoader());
              // }
              callBackChangePassword(initialUri.queryParameters['code'].toString(), initialUri.queryParameters['email'].toString());
              return;
          } else if (initialUri.toString().contains("verification_string")) {
            // navigatorKey.currentState?.pushNamed("/login");

            callBackVerifi(initialUri.queryParameters['verification_string'].toString(), initialUri.queryParameters['email'].toString());
              return;
          }


        }
        // callBackOther();
      } catch (e) {
        // callBackOther();
      }
    }
  }
// static initDynamicLinks(Function(String? id) callback) async {
//   final initialLink = await getInitialLink();
//   if (initialLink != null && !didInitiLinks) {
//     didInitiLinks = true;
//     if (kDebugMode) {
//       print("recieved url " + initialLink);
//     }
//     if (initialLink.contains("https://staging.metagols.com/") ||
//         initialLink.contains("https://www.metaconnectpro.com/") ||
//         initialLink.contains("https://api.metagols.com/")) {
//       callback(initialLink);
//     } else {
//       callback(null);
//     }
//   }
//
//   linkStream.listen((link) {
//     if (link != null) {
//       if (link.contains("https://staging.metagols.com/") ||
//           link.contains("https://www.metaconnectpro.com/") ||
//           link.contains("https://api.metagols.com/")) {
//         callback(link);
//       } else {
//         callback(null);
//       }
//     }
//   });
// }
}
