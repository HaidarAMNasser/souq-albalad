import 'package:souq_al_balad/global/endpoints/product/models/cost_model.dart';

class ServiceModel {
  int? id;
  int? addedBy;
  String? title;
  String? type;
  String? description;
  String? price;
  String? governorate;
  String? location;
  double? longtitude;
  double? latitude;
  String? daysHour;
  String? phoneNumber;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? isActive;
  List<Images>? images;
  List<CostModel>? costs;

  ServiceModel({
    this.id,
    this.addedBy,
    this.title,
    this.type,
    this.description,
    this.price,
    this.governorate,
    this.location,
    this.longtitude,
    this.latitude,
    this.daysHour,
    this.phoneNumber,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.images,
    this.costs
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      ServiceModel.fromMap(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['added_by'] = addedBy;
    data['title'] = title;
    data['type'] = type;
    data['description'] = description;
    data['price'] = price;
    data['governorate'] = governorate;
    data['location'] = location;
    data['long'] = longtitude;
    data['lat'] = latitude;
    data['days_hours'] = daysHour;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_active'] = isActive;
    data['images'] = images?.map((x) => x.toJson()).toList() ?? [];
    data['costs'] = costs?.map((x) => x.toJson()).toList() ?? [];
    return data;
  }

  factory ServiceModel.fromMap(Map<String, dynamic> json) => ServiceModel(
    id: json['id'],
    addedBy: json['added_by'],
    title: json['title'],
    type: json['type'],
    description: json['description'],
    price: json['price'],
    governorate: json['governorate'],
    location: json['location'],
    longtitude: json['long'],
    latitude: json['lat'],
    daysHour: json['days_hours'],
    phoneNumber: json['phone_number'],
    email: json['email'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    isActive: json['is_active'],
    images: json['images'] != null
        ? List<Images>.from(
      json['images'].map((x) => Images.fromJson(x)),
    ) : [],
    costs: json['costs'] != null
        ? List<CostModel>.from(
      json['costs'].map((x) => CostModel.fromJson(x)),
    ) : [],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'added_by': addedBy,
    'title': title,
    'type': type,
    'description': description,
    'price': price,
    'governorate': governorate,
    'location': location,
    'long': longtitude,
    'lat': latitude,
    'days_hours': daysHour,
    'phone_number': phoneNumber,
    'email': email,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'is_active': isActive,
    'images': images,
    'costs': costs,
  };
}

class Images {
  int? id;
  int? serviceId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Images({
    this.id,
    this.serviceId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id: json['id'],
      serviceId: json['service_id'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'service_id': serviceId,
    'image': image,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

