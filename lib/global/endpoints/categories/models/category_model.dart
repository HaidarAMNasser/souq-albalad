import 'package:souq_al_balad/global/endpoints/categories/models/sub_category_model.dart';

class CategoryModel {
  int? id;
  String? name;
  String? image;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<SubCategoryModel>? subCategories;

  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      subCategories:
          json['sub_categories'] != null
              ? List<SubCategoryModel>.from(
                json['sub_categories'].map((x) => SubCategoryModel.fromJson(x)),
              )
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['sub_categories'] = subCategories?.map((x) => x.toJson()).toList();
    return data;
  }
}
