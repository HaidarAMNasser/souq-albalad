

class UserRegModel {
  User user;
  String accessToken;

  UserRegModel({
    required this.user,
    required this.accessToken,
  });

  factory UserRegModel.fromJson(Map<String, dynamic> json) => UserRegModel(
    user: User.fromJson(json["user"]),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "access_token": accessToken,
  };
}

class User {
  String firstName;
  String lastName;
  String phone;
  Address address;
  UserSetting userSetting;
  String id;
  String role;
  bool isBlocked;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.userSetting,
    required this.id,
    required this.role,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    address: Address.fromJson(json["address"]),
    userSetting: UserSetting.fromJson(json["userSetting"]),
    id: json["id"],
    role: json["role"],
    isBlocked: json["isBlocked"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "address": address.toJson(),
    "userSetting": userSetting.toJson(),
    "id": id,
    "role": role,
    "isBlocked": isBlocked,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Address {
  String state;
  String city;
  dynamic streetLine;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  Address({
    required this.state,
    required this.city,
    required this.streetLine,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    state: json["state"],
    city: json["city"],
    streetLine: json["streetLine"],
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "state": state,
    "city": city,
    "streetLine": streetLine,
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class UserSetting {
  bool hidePhoneNumber;
  String id;

  UserSetting({
    required this.hidePhoneNumber,
    required this.id,
  });

  factory UserSetting.fromJson(Map<String, dynamic> json) => UserSetting(
    hidePhoneNumber: json["hidePhoneNumber"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "hidePhoneNumber": hidePhoneNumber,
    "id": id,
  };
}
