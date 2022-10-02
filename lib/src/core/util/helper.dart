import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' as intl;
import 'package:nft_deaa/src/core/app_constants.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/core/data/data_sources/app_shared_prefs.dart';
import 'package:nft_deaa/src/core/data/entities/user.dart';

// import 'package:fluttertoast/fluttertoast.dart';
import 'package:nft_deaa/src/core/translations/l10n.dart';
import 'package:nft_deaa/src/core/util/AppSnackBar.dart';
import 'package:nft_deaa/src/features/auth/data/data_sources/auth_shared_prefs.dart';
class Helper {
  // static final Singleton _singleton = Singleton._internal();
  static String? deviceLanguageCode;

  // factory Singleton() {
  //   return _singleton;
  // }
  //
  // Singleton._internal();

  static String getLang() {
    String? lang;
    lang = sl<AppSharedPrefs>().getLang();
    // deviceLanguageCode = Platform.localeName.split('_')[0];
    lang = lang ?? "en";
    return lang;
  }

  static String getDateFormat({String? timeString}) {
    return timeString == null ? "" : DateFormat('dd MMMM y').format(DateTime.parse(timeString)).toString();
  }


  static DateTime? getDate({String? timeString}) {
    return timeString == null ? null : DateTime.parse(timeString);
  }

  static String getPriceFormat({required double number}) {
    int num1 = int.parse("$number".split(".")[0]);
    String num2 = "00";
    if ("$number".split(".").length > 1) {
      if ("$number".split(".")[1].length > 2) {
        num2 = "$number".split(".")[1].substring(0, 2);
      } else {
        num2 = "${"$number".split(".")[1].substring(0, "$number".split(".")[1].length)}0";
      }
    }
    return intl.NumberFormat.decimalPattern().format(double.parse("$num1.${num2}"));
  }

  static double getRoundNumber({required double number, int round = 2}) {
    return double.parse(number.toStringAsFixed(2));
  }

  // static bool  getIsLoginUser( ) {
  // User user = sl<AuthSharedPrefs>().getUser();
  // return ((user.id ?? -1) > 0);
  // }

  /// Get svg images
  static getSvgImage(String filename) {
    return SVG_PATH + filename;
  }

  /// Get images
  static getImage(String filename) {
    return IMAGE_PATH + filename;
  }

  /// Show toast message
  static showSnackBar(BuildContext context, String message, {ToastType type = ToastType.info}) {
    AppSnackBar.show(context, message, type);

  }

  /// Get user information
  static User getUser() {
    User? user;
    user = sl<AuthSharedPrefs>().getUser();
    return user;
  }
  //isUrl Or isPath
  static bool isUrlImage(String imagePath){
    if((Uri.parse(imagePath).isAbsolute)){
      return true;
    }
    return !File(imagePath).existsSync() ;
  }

  /// Get language name of lang code, ex: langCode = en => English
  static String getLangName(BuildContext context, String langCode) {
    if (langCode == "en") {
      return S.of(context).english;
    } else if (langCode == "ar") {
      return S.of(context).arabic;
    } else {
      return S.of(context).english;
    }
  }
}
