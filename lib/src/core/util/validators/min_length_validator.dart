// import 'package:flutter/material.dart';
// import 'package:nft_deaa/src/core/translations/l10n.dart';
// import 'base_validator.dart';
//
// class MinLengthValidator extends BaseValidator {
//   final int minLength;
//   bool? isFromVerificationPage;
//
//   MinLengthValidator({required this.minLength, this.isFromVerificationPage});
//
//
//   @override
//   String getMessage(BuildContext? context) {
//     if (isFromVerificationPage != null && isFromVerificationPage!) return '*';
//     return S.of(context!).weak_password_message;
//   }
//
//   @override
//   bool validate(String value) {
//     return value.length >= minLength;
//   }
// }
