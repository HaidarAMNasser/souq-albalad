import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/categories/models/sub_category_model.dart';
import 'package:souq_al_balad/global/endpoints/product/models/cost_model.dart';
import 'package:souq_al_balad/global/endpoints/product/models/product_details.dart';
import 'package:souq_al_balad/global/endpoints/product/models/product_model.dart';
import 'package:souq_al_balad/global/endpoints/review/models/review_model.dart';

class ProductBundleModel {
  ProductModel? product;
  CategoryModel? category;
  SubCategoryModel? subCategory;
  List<String>? images;
  ProductDetailsModel? details;
  List<ReviewModel>? reviews;
  List<CostModel>? costs;

  ProductBundleModel({
    this.product,
    this.category,
    this.subCategory,
    this.images,
    this.details,
    this.reviews,
    this.costs,
  });

  factory ProductBundleModel.fromJson(Map<String, dynamic> json) {
    return ProductBundleModel(
      product:
          json['product'] != null
              ? ProductModel.fromJson(json['product'])
              : null,
      category:
          json['category'] != null
              ? CategoryModel.fromJson(json['category'])
              : null,
      subCategory:
          json['subCategory'] != null
              ? SubCategoryModel.fromJson(json['subCategory'])
              : null,
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      details:
          json['details'] != null
              ? ProductDetailsModel.fromJson(json['details'])
              : null,
      reviews:
          json['reviews'] != null
              ? List<ReviewModel>.from(
                json['reviews'].map((x) => ReviewModel.fromJson(x)),
              )
              : [],
      costs:
      json['costs'] != null
          ? List<CostModel>.from(
        json['costs'].map((x) => CostModel.fromJson(x)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) data['product'] = product!.toJson();
    if (category != null) data['category'] = category!.toJson();
    if (subCategory != null) data['subCategory'] = subCategory!.toJson();
    data['images'] = images ?? [];
    if (details != null) data['details'] = details!.toJson();
    data['reviews'] = reviews?.map((x) => x.toJson()).toList() ?? [];
    data['costs'] = costs?.map((x) => x.toJson()).toList() ?? [];
    return data;
  }
}
