import 'package:souq_al_balad/global/endpoints/signup/models/sign_up_merchant_model.dart';
import 'package:souq_al_balad/global/endpoints/signup/models/sign_up_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

abstract class SignUpEvents {
  const SignUpEvents();
}

class SignUpUserEvent extends SignUpEvents {
  SignUpUserModel signUpModel;
  GlobalKey<FormState> formKey;
  BuildContext context;

  SignUpUserEvent(this.signUpModel, this.context, this.formKey);
}

class SignUpMerchantEvent extends SignUpEvents {
  SignUpMerchantModel signUpModel;
  GlobalKey<FormState> formKey;
  BuildContext context;

  SignUpMerchantEvent(this.signUpModel, this.context, this.formKey);
}

class SignUpWithFacebook extends SignUpEvents {
  BuildContext context;
  SignUpWithFacebook(this.context);
}

class SetIsTrader extends SignUpEvents {
  bool isTrader;
  SetIsTrader(this.isTrader);
}

class SetImage extends SignUpEvents {
  XFile? image;
  SetImage(this.image);
}

class SignUpWithGmail extends SignUpEvents {
  BuildContext context;
  SignUpWithGmail(this.context);
}
