import 'package:souq_al_balad/global/endpoints/product/models/cost_model.dart';

class FavoriteModel {

  int? favoriteId;
  ProductModel? favorite;
  String? addedAt;

  FavoriteModel({
    this.favoriteId,
    this.favorite,
    this.addedAt
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      favoriteId: json['favorite_id'],
      favorite: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      addedAt: json['added_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favorite_id'] = favoriteId;
    if (favorite != null) data['product'] = favorite!.toJson();
    data['added_at'] = addedAt;
    return data;
  }
}

class ProductModel {
  int? id;
  int? addedBy;
  int? categoryId;
  int? subCategoryId;
  String? price;
  int? views;
  int? favoritesNumber;
  int? isFeatured;
  String? priceType;
  String? state;
  String? title;
  String? governorate;
  String? addressDetails;
  double? longtitude;
  double? latitude;
  String? description;
  String? phoneNumber;
  String? email;
  String? createdAt;
  String? updatedAt;
  dynamic finalPrice;
  List<Images>? images;
  List<CostModel>? costs;

  ProductModel({
    this.id,
    this.addedBy,
    this.categoryId,
    this.subCategoryId,
    this.price,
    this.views,
    this.favoritesNumber,
    this.isFeatured,
    this.priceType,
    this.state,
    this.title,
    this.governorate,
    this.addressDetails,
    this.description,
    this.phoneNumber,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.finalPrice,
    this.images,
    this.costs
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductModel.fromMap(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['added_by'] = addedBy;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['price'] = price;
    data['views'] = views;
    data['favorites_number'] = favoritesNumber;
    data['is_featured'] = isFeatured;
    data['price_type'] = priceType;
    data['state'] = state;
    data['title'] = title;
    data['governorate'] = governorate;
    data['address_details'] = addressDetails;
    data['description'] = description;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['final_price'] = finalPrice;
    if (images != null) {
      data['images'] = images!.map((e) => e.toJson()).toList();
    }
    if (costs != null) {
      data['costs'] = costs!.map((e) => e.toJson()).toList();
    }
    return data;
  }

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    addedBy: json['added_by'],
    categoryId: json['category_id'],
    subCategoryId: json['sub_category_id'],
    price: json['price'],
    views: json['views'],
    favoritesNumber: json['favorites_number'],
    isFeatured: json['is_featured'],
    priceType: json['price_type'],
    state: json['state'],
    title: json['title'],
    governorate: json['governorate'],
    addressDetails: json['address_details'],
    description: json['description'],
    phoneNumber: json['phone_number'],
    email: json['email'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    finalPrice: json['final_price'],
    images: (json['images'] as List)
        .map((e) => Images.fromJson(e))
        .toList(),
    costs: (json['costs'] as List)
        .map((e) => CostModel.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'added_by': addedBy,
    'category_id': categoryId,
    'sub_category_id': subCategoryId,
    'price': price,
    'views': views,
    'favorites_number': favoritesNumber,
    'is_featured': isFeatured,
    'price_type': priceType,
    'state': state,
    'title': title,
    'governorate': governorate,
    'address_details': addressDetails,
    'description': description,
    'phone_number': phoneNumber,
    'email': email,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'final_price': finalPrice,
    'images': images,
    'costs': costs,
  };
}

class Images {
  int? id;
  int? productId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Images({
    this.id,
    this.productId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
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

