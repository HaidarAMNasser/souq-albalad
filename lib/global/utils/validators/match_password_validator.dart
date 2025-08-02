import 'package:flutter/material.dart';
import 'base_validator.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';

class MatchPasswordValidator extends BaseValidator {
  final String originalPassword;

  MatchPasswordValidator(this.originalPassword);

  @override
  String getMessage(BuildContext context) {
    return "${AppLocalization.of(context).translate('passwords_do_not_match')} *";
  }

  @override
  bool validate(String value) {
    return value == originalPassword;
  }
}
