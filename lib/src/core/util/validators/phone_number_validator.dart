import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/translations/l10n.dart';

import 'package:nft_deaa/src/core/core.dart';

import 'base_validator.dart';


class PhoneNumberValidator extends BaseValidator {
  String  phoneNumber;

  PhoneNumberValidator({required this.phoneNumber, });


  @override
  String getMessage(BuildContext? context) {
    return S.of(context!).incorrect_phone_number;
  }

  @override
  bool validate(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value.trim())) {
      return false;
    }
    return true;
  }
}
