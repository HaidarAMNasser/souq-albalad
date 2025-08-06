
class SellerModel {
  SellerInfoModel? sellerInfoModel;

  SellerModel({
    this.sellerInfoModel,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
      sellerInfoModel: json['seller'] != null
          ? SellerInfoModel.fromJson(json['seller'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (SellerInfoModel != null) data['seller'] = SellerInfoModel().toJson();
    return data;
  }
}



class SellerInfoModel {
  int? id;
  int? userId;
  String? storeOwnerName;
  String? storeName;
  String? address;
  String? logo;
  String? description;
  int? isFeatured;
  String? status;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? coverImage;

  SellerInfoModel({
    this.id,
    this.userId,
    this.storeOwnerName,
    this.storeName,
    this.address,
    this.logo,
    this.description,
    this.isFeatured,
    this.status,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.coverImage,
  });

  factory SellerInfoModel.fromJson(Map<String, dynamic> json) {
    return SellerInfoModel(
      id: json['id'],
      userId: json['user_id'],
      storeOwnerName: json['store_owner_name'],
      storeName: json['store_name'],
      address: json['address'],
      logo: json['logo'],
      description: json['description'],
      isFeatured: json['is_featured'],
      status: json['status'],
      phone: json['phone'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      coverImage: json['cover_image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['store_owner_name'] = storeOwnerName;
    data['store_name'] = storeName;
    data['address'] = address;
    data['logo'] = logo;
    data['description'] = description;
    data['is_featured'] = isFeatured;
    data['status'] = status;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cover_image'] = coverImage;
    return data;
  }
}
