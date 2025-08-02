import 'package:souq_al_balad/global/endpoints/product/models/product_model.dart';

class SubCategoryModel {
  int? id;
  int? categoryId;
  String? name;
  String? image;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<ProductModel>? products;

  SubCategoryModel({
    this.id,
    this.categoryId,
    this.name,
    this.image,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        id: json['id'],
        categoryId: json['category_id'],
        name: json['name'],
        image: json['image'],
        deletedAt: json['deleted_at'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        products:
            json['products'] != null
                ? List<ProductModel>.from(
                  json['products'].map((x) => ProductModel.fromJson(x)),
                )
                : [],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['image'] = image;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['products'] = products?.map((x) => x.toJson()).toList();
    return data;
  }
}
