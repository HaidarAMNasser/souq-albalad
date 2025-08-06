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
      };
}
