import 'package:souq_al_balad/global/endpoints/signup/models/sign_up_merchant_model.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class AccountEvents {
  const AccountEvents();
}

class LogoutEvent extends AccountEvents {
  BuildContext context;
  LogoutEvent(this.context);
}

class ChangePasswordEvent extends AccountEvents {
  String oldPassword;
  String password;
  String confirmPassword;
  BuildContext context;

  ChangePasswordEvent(
    this.oldPassword,
    this.password,
    this.confirmPassword,
    this.context,
  );
}

class GetSellerProfileEvent extends AccountEvents {
  BuildContext context;
  GetSellerProfileEvent(this.context);
}

class SetImage extends AccountEvents {
  XFile? image;
  SetImage(this.image);
}

class EditSellerProfileEvent extends AccountEvents {
  SignUpMerchantModel seller;
  GlobalKey<FormState> formKey;
  BuildContext context;

  EditSellerProfileEvent(this.seller, this.context, this.formKey);
}

class GetUserProfileEvent extends AccountEvents {
  BuildContext context;
  GetUserProfileEvent(this.context);
}

class EditUserProfileEvent extends AccountEvents {
  UserModel user;
  GlobalKey<FormState> formKey;
  BuildContext context;

  EditUserProfileEvent(this.user, this.context, this.formKey);
}
