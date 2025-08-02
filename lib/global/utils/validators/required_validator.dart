import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  @override
  String getMessage(BuildContext context) {
    return "${AppLocalization.of(context).translate('field_required')} * ";
  }

  @override
  bool validate(String value) {
    return value.isNotEmpty;
  }
}
