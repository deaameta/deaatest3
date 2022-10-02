import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/translations/l10n.dart';

import 'base_validator.dart';

class MatchValidator extends BaseValidator {
  String value;

  MatchValidator({required this.value});

  @override
  String getMessage(BuildContext? context) {
    return S.of(context!).password_does_not_match;
  }

  @override
  bool validate(String value) {
    return value == this.value;
  }
}
