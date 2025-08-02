import 'package:flutter/material.dart';
import 'base_validator.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';

class EmailValidator extends BaseValidator {
  @override
  String getMessage(BuildContext context) {
    return "${AppLocalization.of(context).translate('invalid_email')} *";
  }

  @override
  bool validate(String value) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(value.trim());
  }
}
