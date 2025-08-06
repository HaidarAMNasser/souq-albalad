import 'package:image_picker/image_picker.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? age;
  String? emailVerifiedAt;
  int? isActive;
  String? provider;
  String? status;
  String? providerId;
  String? firebaseToken;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  XFile? logo;
  String? logoPathFromServer;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.age,
    this.emailVerifiedAt,
    this.isActive,
    this.provider,
    this.status,
    this.providerId,
    this.firebaseToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.logo,
    this.logoPathFromServer
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      age: json['age'],
      emailVerifiedAt: json['email_verified_at'],
      isActive: json['is_active'],
      provider: json['provider'],
      status: json['status'],
      providerId: json['provider_id'],
      firebaseToken: json['firebase_token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      logoPathFromServer: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['age'] = age;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_active'] = isActive;
    data['provider'] = provider;
    data['status'] = status;
    data['provider_id'] = providerId;
    data['firebase_token'] = firebaseToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
