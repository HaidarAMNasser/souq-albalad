import 'dart:convert';

class SignUpUserModel {
  String name;
  String age;
  String email;
  String password;
  String password_confirmation;
  String phone;

  SignUpUserModel({
    required this.name,
    required this.age,
    required this.password,
    required this.password_confirmation,
    required this.email,
    required this.phone,
  });

  factory SignUpUserModel.fromJson(Map<String, dynamic> json) =>
      SignUpUserModel.fromMap(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["age"] = age;
    data["password"] = password;
    data["password_confirmation"] = password_confirmation;
    data["email"] = email;
    data["phone"] = phone;
    return data;
  }

  // factory SignUpModel.EmptyMessageSuccess() => SignUpModel(isSuccess: true);

  factory SignUpUserModel.fromMap(Map<String, dynamic> json) => SignUpUserModel(
        name: json['name'],
        age: json['age'],
        password: json['password'],
        password_confirmation: json['password_confirmation'],
        email: json['email'],
        phone: json['phone'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'age': age,
        'password': password,
        'password_confirmation': password_confirmation,
        'email': email,
        'phone': phone,
      };
}
