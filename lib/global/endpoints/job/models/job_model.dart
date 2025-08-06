import 'package:souq_al_balad/global/endpoints/product/models/cost_model.dart';

class JobModel {
  int? id;
  int? addedBy;
  String? title;
  String? jobType;
  String? governorate;
  String? location;
  double? longtitude;
  double? latitude;
  String? jobTitle;
  String? type;
  String? salary;
  String? education;
  String? experience;
  String? skills;
  String? description;
  String? workHours;
  String? startDate;
  String? phoneNumber;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? isActive;
  List<Images>? images;
  List<CostModel>? costs;

  JobModel({
    this.id,
    this.addedBy,
    this.title,
    this.jobType,
    this.governorate,
    this.location,
    this.longtitude,
    this.latitude,
    this.jobTitle,
    this.type,
    this.salary,
    this.education,
    this.experience,
    this.skills,
    this.description,
    this.workHours,
    this.startDate,
    this.phoneNumber,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.images,
    this.costs
  });

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      JobModel.fromMap(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['added_by'] = addedBy;
    data['title'] = title;
    data['job_type'] = jobType;
    data['governorate'] = governorate;
    data['location'] = location;
    data['long'] = longtitude;
    data['lat'] = latitude;
    data['job_title'] = jobTitle;
    data['type'] = type;
    data['salary'] = salary;
    data['education'] = education;
    data['experience'] = experience;
    data['skills'] = skills;
    data['description'] = description;
    data['work_hours'] = workHours;
    data['start_date'] = startDate;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_active'] = isActive;
    data['images'] = images?.map((x) => x.toJson()).toList() ?? [];
    data['costs'] = costs?.map((x) => x.toJson()).toList() ?? [];
    return data;
  }

  factory JobModel.fromMap(Map<String, dynamic> json) => JobModel(
    id: json['id'],
    addedBy: json['added_by'],
    title: json['title'],
    jobType: json['job_type'],
    governorate: json['governorate'],
    location: json['location'],
    longtitude: json['long'],
    latitude: json['lat'],
    jobTitle: json['job_title'],
    type: json['type'],
    salary: json['salary'],
    education: json['education'],
    experience: json['experience'],
    skills: json['skills'],
    description: json['description'],
    workHours: json['work_hours'],
    startDate: json['start_date'],
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
    'job_type': jobType,
    'governorate': governorate,
    'location': location,
    'long': longtitude,
    'lat': latitude,
    'job_title': jobTitle,
    'type': type,
    'salary': salary,
    'education': education,
    'experience': experience,
    'skills': skills,
    'description': description,
    'work_hours': workHours,
    'start_date': startDate,
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
  int? jobAdId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Images({
    this.id,
    this.jobAdId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id: json['id'],
      jobAdId: json['job_ad_id'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'job_ad_id': jobAdId,
    'image': image,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
