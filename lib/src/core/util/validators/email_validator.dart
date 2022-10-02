import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/core.dart';

import 'base_validator.dart';

import 'package:nft_deaa/src/core/translations/l10n.dart';

class EmailValidator extends BaseValidator {
  @override
  String getMessage(BuildContext? context) {
    return S.of(context!).email_not_valid;
  }

  @override
  bool validate(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}
