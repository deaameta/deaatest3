import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/translations/l10n.dart';

import 'base_validator.dart';

class CodeValidator extends BaseValidator {
  bool? isFromVerificationPage;

  CodeValidator({this.isFromVerificationPage});

  @override
  String getMessage(BuildContext? context) {
    if (isFromVerificationPage != null && isFromVerificationPage!) return '*';
    return S.of(context!).invalid_code;
  }

  @override
  bool validate(String value) {
    String pattern = r'^[0-9]{6,6}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value.trim())) {
      return false;
    }
    return true;
  }
}
