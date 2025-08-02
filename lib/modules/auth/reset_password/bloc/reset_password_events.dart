import 'package:souq_al_balad/global/endpoints/forget_password/models/reset_password_model.dart';
import 'package:flutter/src/widgets/framework.dart';

abstract class ResetPasswordEvents {
  const ResetPasswordEvents();
}

class ResetPasswordEvent extends ResetPasswordEvents {
  ResetPasswordModel resetPasswordModel;
  BuildContext context;

  ResetPasswordEvent(this.resetPasswordModel, this.context);
}
