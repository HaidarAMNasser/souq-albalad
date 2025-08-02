import 'dart:convert';

class ResetPasswordModel {
  String email;
  String token;
  String password;
  String password_confirmation;

  ResetPasswordModel({
    required this.email,
    required this.token,
    required this.password,
    required this.password_confirmation,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["token"] = token;
    data["password"] = password;
    data["password_confirmation"] = password_confirmation;
    return data;
  }
}
