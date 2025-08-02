import 'package:flutter/src/widgets/framework.dart';

abstract class OtpEvents {
  const OtpEvents();
}

class SendOtpEvent extends OtpEvents {
  String email;
  String otp;
  BuildContext context;

  SendOtpEvent(this.email, this.otp, this.context);
}
