import 'package:flutter/src/widgets/framework.dart';

abstract class LoginEvents {
  const LoginEvents();
}

class LoginEvent extends LoginEvents {
  String email;
  String password;
  BuildContext context;

  LoginEvent(this.email, this.password, this.context);
}

class LoginGuestEvent extends LoginEvents {
  BuildContext context;

  LoginGuestEvent(this.context);
}

class LoginWithFacebook extends LoginEvents {
  BuildContext context;
  LoginWithFacebook(this.context);
}

class LoginWithGmail extends LoginEvents {
  BuildContext context;
  LoginWithGmail(this.context);
}
