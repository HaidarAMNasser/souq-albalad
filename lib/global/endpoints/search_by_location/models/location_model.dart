
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
  String? image;

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
      image: json['image'],
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
    data['image'] = image;
    return data;
  }
}
