import 'package:flutter/material.dart';
import 'package:nft_deaa/src/core/translations/l10n.dart';

import 'base_validator.dart';

class PasswordValidator extends BaseValidator {
  bool? isFromVerificationPage;
  bool? message;
  List<PasswordValidType> typeValids = [];

  PasswordValidator({this.isFromVerificationPage});

  @override
  String getMessage(BuildContext? context) {
    if (isFromVerificationPage != null && isFromVerificationPage!) return '*';
    String message = "";
    if (context != null) {
      typeValids.forEach((element) {
        switch (element) {
          case PasswordValidType.password_is_empty:
            message = message + S.of(context).password_is_empty;
            break;
          case PasswordValidType.password_should_contain_at_least_8_charachters:
            message = message + S.of(context).password_should_contain_at_least_8_charachters;
            break;
          case PasswordValidType.password_should_contain_at_least_one_lowercase_letter:
            message = message + S.of(context).password_should_contain_at_least_one_lowercase_letter;
            break;
          case PasswordValidType.password_should_contain_at_least_one_number:
            message = message + S.of(context).password_should_contain_at_least_one_number;
            break;
          case PasswordValidType.password_should_contain_at_least_one_symobol:
            message = message + S.of(context).password_should_contain_at_least_one_symobol;
            break;
          case PasswordValidType.password_should_contain_at_least_one_upercase_letter:
            message = message + S.of(context).password_should_contain_at_least_one_upercase_letter;
            break;
        }
      });
    }

    return message == "" ? S.of(context!).weak_password_message : message;
  }

  @override
  bool validate(String value) {
    typeValids.clear();
    if (value.isEmpty) {
      this.typeValids.add(PasswordValidType.password_is_empty);
      return false;
    }
    // if (!RegExp("(?=.*^[\u0600-\u06FF])").hasMatch(value.trim())) this.typeValids.add(PasswordValidType.password_should_contain_at_least_one_lowercase_letter);

    if (value.length < 8) this.typeValids.add(PasswordValidType.password_should_contain_at_least_8_charachters);
    if (!RegExp("(.*([\u0621-\u064A])+.*)").hasMatch(value.trim())) {
      if (!RegExp("(?=.*[a-z])").hasMatch(value.trim())) this.typeValids.add(PasswordValidType.password_should_contain_at_least_one_lowercase_letter);
      if (!RegExp("(?=.*[A-Z])").hasMatch(value.trim())) this.typeValids.add(PasswordValidType.password_should_contain_at_least_one_upercase_letter);
    }
    if (!RegExp("(?=.*([0-9]|[\u0660-\u0669]))").hasMatch(value.trim()))
      this.typeValids.add(PasswordValidType.password_should_contain_at_least_one_number);

    bool isSpectal = false;
    for (int i = 0; i < value.split('').length; i++)
      if (!RegExp(".*([0-9A-Z\u0660-\u0669a-z\u0621-\u064A])").hasMatch(value.split('')[i])) {
        isSpectal = true;

        break;
      }
    if (!isSpectal) {
      this.typeValids.add(PasswordValidType.password_should_contain_at_least_one_symobol);
    }

    return typeValids.isEmpty;
  }
}

enum PasswordValidType {
  password_is_empty,
  password_should_contain_at_least_8_charachters,
  password_should_contain_at_least_one_lowercase_letter,
  password_should_contain_at_least_one_number,
  password_should_contain_at_least_one_symobol,
  password_should_contain_at_least_one_upercase_letter
}
