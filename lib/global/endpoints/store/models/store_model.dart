class StoreModel {
  int? id;
  String? storeOwnerName;
  String? storeName;
  String? address;
  String? logo;
  String? description;
  int? isFeatured;
  String? createdAt;
  String? updatedAt;

  StoreModel({
    this.id,
    this.storeOwnerName,
    this.storeName,
    this.address,
    this.logo,
    this.description,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      storeOwnerName: json['store_owner_name'],
      storeName: json['store_name'],
      address: json['address'],
      logo: json['logo'],
      description: json['description'],
      isFeatured: json['is_featured'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_owner_name'] = storeOwnerName;
    data['store_name'] = storeName;
    data['address'] = address;
    data['logo'] = logo;
    data['description'] = description;
    data['is_featured'] = isFeatured;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
