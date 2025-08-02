import 'package:flutter/material.dart';
import 'base_validator.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';

class PasswordValidator extends BaseValidator {
  @override
  String getMessage(BuildContext context) {
    return "${AppLocalization.of(context).translate('invalid_password')} *";
  }

  @override
  bool validate(String value) {
    return value.trim().length >= 6;
  }
}
