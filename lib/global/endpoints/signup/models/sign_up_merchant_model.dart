import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class SignUpMerchantModel {
  String store_owner_name;
  String store_name;
  String address;
  String description;
  String phone;
  String email;
  String password;
  String password_confirmation;
  XFile? logo;
  String? logoPathFromServer;
  XFile? coverImage;
  String? coverImagePathFromServer;

  SignUpMerchantModel({
    required this.store_owner_name,
    required this.store_name,
    required this.address,
    required this.description,
    required this.phone,
    required this.email,
    required this.password,
    required this.password_confirmation,
    this.logo,
    this.logoPathFromServer,
    this.coverImage,
    this.coverImagePathFromServer
  });

  factory SignUpMerchantModel.fromJson(Map<String, dynamic> json) =>
      SignUpMerchantModel.fromMap(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["store_owner_name"] = store_owner_name;
    data["store_name"] = store_name;
    data["address"] = address;
    data["description"] = description;
    data["phone"] = phone;
    data["email"] = email;
    data["password"] = password;
    data["password_confirmation"] = password_confirmation;
    if (logo == null && logoPathFromServer != null) {
      data["logo"] = logoPathFromServer;
    }
    if (coverImage == null && coverImagePathFromServer != null) {
      data["cover_image"] = coverImagePathFromServer;
    }
    return data;
  }

  // factory SignUpModel.EmptyMessageSuccess() => SignUpModel(isSuccess: true);

  factory SignUpMerchantModel.fromMap(Map<String, dynamic> json) =>
      SignUpMerchantModel(
        store_owner_name: json['store_owner_name'],
        store_name: json['store_name'],
        address: json['address'],
        description: json['description'],
        phone: json['phone'],
        email: json['email'],
        password: json['password'],
        password_confirmation: json['password_confirmation'],
        logoPathFromServer: json['logo'],
        coverImagePathFromServer: json['cover_image'],
      );

  Map<String, dynamic> toMap() => {
    'store_owner_name': store_owner_name,
    'store_name': store_name,
    'address': address,
    'description': description,
    'phone': phone,
    'email': email,
    'password': password,
    'password_confirmation': password_confirmation,
    if (logo == null && logoPathFromServer != null)
      'logo': logoPathFromServer,
    if (coverImage == null && coverImagePathFromServer != null)
      'cover_image': coverImagePathFromServer,
  };
}
