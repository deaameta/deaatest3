import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/size_config.dart';
import 'package:nft_deaa/src/core/util/helper.dart';

import 'core.dart';

class AppStyle {
////////////////////////////////////////////////Bold////////////////////////////////////////////////

  static TextStyle bold({required double size, String? lang}) {
    lang ??= Helper.getLang();
    return TextStyle(
        fontFamily: lang == "ar" ? "HstSh" : "MyriadPro", fontWeight: FontWeight.bold, fontSize: SizeConfig.h(size), color: AppColors.primaryColor);
  }

////////////////////////////////////////////////SmiBold////////////////////////////////////////////////

  static TextStyle smiBold({required double size, String? lang}) {
    lang ??= Helper.getLang();
    return TextStyle(
        fontFamily: lang == "ar" ? "HstSh" : "MyriadPro", fontWeight: FontWeight.w600, fontSize: SizeConfig.h(size), color: AppColors.primaryColor);
  }

////////////////////////////////////////////////Med////////////////////////////////////////////////

  static TextStyle med({required double size, String? lang}) {
    lang ??= Helper.getLang();
    return TextStyle(
        fontFamily: lang == "ar" ? "HstSh" : "MyriadPro", fontWeight: FontWeight.w500, fontSize: SizeConfig.h(size), color: AppColors.primaryColor);
  }

  ////////////////////////////////////////////////Regular////////////////////////////////////////////////

  static TextStyle regular({required double size, String? lang}) {
    lang ??= Helper.getLang();
    return TextStyle(fontFamily: lang == "ar" ? "HstSh" : "MyriadPro", fontSize: SizeConfig.h(size), color: AppColors.primaryColor);
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////

  static BoxShadow basicBoxShadow = BoxShadow(offset: const Offset(0.0, 3.0), color: Colors.black.withOpacity(0.2), blurRadius: 6);
  static final BorderRadius basicBorderRadius = BorderRadius.circular(7);
  static final bottomNavHieght = SizeConfig.h(67);
}

class AppColors {
  static const Color transparent = Colors.transparent;
  static const Color backgroundColor = Color(0xFF161A22);
  static const Color backgroundColor2 = Color(0xFF1C1E26);
  static const Color primaryColor = Color(0xFFDFA963);
  static const Color primaryColor2 = Color(0xFFEDC57A);
  static const Color primaryColor3 = Color(0xFFE1AC7B);
  static const Color darkPrimaryColor = Color(0xFFA58D5F);
  static const Color secondaryColor = Color(0xFFDEA36D);
  static const Color darkSecondaryColor = Color(0xFF836734);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lineGrey = Color(0xFF343243);
  static const Color black = Color(0xFF000000);
  static const Color primaryGrey = Color(0xFF8D8F92);
  static const Color primaryGrey1 = Color(0x56D9D9DA);
  static const Color secondaryGrey = Color(0xFFB6B0AA);
  static const Color tableTextGray = Color(0xFF8A8C90);
  static const Color subscriptionGray = Color(0xFF999999);
  static const Color darkGray = Color(0xFF2A2D30);
  static const Color greenColor = Color(0xFF00CA2C);
  static const Color redColor = Color(0xFFF00000);
  static const Color lightGrey = Color(0xFF9CA1C2);
  static const Color primaryColorNew = Color(0xFFFF6600);
  static const Color darkPrimaryColorNew = Color(0xFFB25211);
  static const Color lightPrimaryColorNew = Color(0xFFFF8A3D);
  static const Color secondaryColorNew = Color(0xFF33FF99);
  static const Color backgroundColorNew = Color(0xFF060226);
}
