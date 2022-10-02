import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/translations/l10n.dart';

import 'base_validator.dart';

class UserNameValidator extends BaseValidator {
  bool? isFromVerificationPage;

  UserNameValidator({this.isFromVerificationPage});

  @override
  String getMessage(BuildContext? context) {
    if (isFromVerificationPage != null && isFromVerificationPage!) return '*';
    return S.of(context!).incorrect_username;
  }

  @override
  bool validate(String value) {
    String pattern = (r"([\u0621-\u064a-\_]*)");
    RegExp regExp = RegExp(pattern);
    if (value.length < 2 || value.contains(" ")) {
      return false;
    } else if (!regExp.hasMatch(value.trim())) {
      return false;
    }
    return true;
  }
}
