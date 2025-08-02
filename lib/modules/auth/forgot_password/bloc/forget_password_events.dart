import 'package:flutter/src/widgets/framework.dart';

abstract class ForgetPasswordEvents {
  const ForgetPasswordEvents();
}

class ForgetPasswordEvent extends ForgetPasswordEvents {
  String email;
  BuildContext context;

  ForgetPasswordEvent(this.email, this.context);
}

