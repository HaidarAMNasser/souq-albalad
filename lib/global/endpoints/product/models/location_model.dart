
class LocationModel {

  int? id;
  String? type;
  String? title;
  int? distance;
  double? latitude;
  double? longitude;
  String? price;
  String? category;
  String? salary;
  String? jobTitle;
  String? serviceType;
  Image? image;

  LocationModel({
    this.id,
    this.type,
    this.title,
    this.distance,
    this.latitude,
    this.longitude,
    this.price,
    this.category,
    this.salary,
    this.jobTitle,
    this.serviceType,
    this.image,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      distance: json['distance'],
      latitude: json['lat'],
      longitude: json['long'],
      price: json['price'],
      category: json['category'],
      salary: json['salary'],
      jobTitle: json['job_title'],
      serviceType: json['service_type'],
      image:
      json['image'] != null
          ? Image.fromJson(json['image'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['distance'] = distance;
    data['lat'] = latitude;
    data['long'] = longitude;
    data['price'] = price;
    data['category'] = category;
    data['salary'] = salary;
    data['job_title'] = jobTitle;
    data['service_type'] = serviceType;
    if (image != null) data['image'] = image!.toJson();
    return data;
  }
}


class Image {
  int? id;
  int? productId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Image({
    this.id,
    this.productId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      productId: json['product_id'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'image': image,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

