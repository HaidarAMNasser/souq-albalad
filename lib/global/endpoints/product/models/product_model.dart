class ProductModel {
  int? id;
  int? added_by;
  int? category_id;
  int? sub_category_id;
  String? price;
  int? views;
  int? favorites_number;
  int? is_featured;
  String? price_type;
  String? state;
  String? title;
  String? governorate;
  String? address_details;
  String? description;
  String? phone_number;
  String? email;
  String? created_at;
  String? updated_at;
  dynamic final_price;

  ProductModel({
    this.id,
    this.added_by,
    this.category_id,
    this.sub_category_id,
    this.price,
    this.views,
    this.favorites_number,
    this.is_featured,
    this.price_type,
    this.state,
    this.title,
    this.governorate,
    this.address_details,
    this.description,
    this.phone_number,
    this.email,
    this.created_at,
    this.updated_at,
    this.final_price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductModel.fromMap(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['added_by'] = added_by;
    data['category_id'] = category_id;
    data['sub_category_id'] = sub_category_id;
    data['price'] = price;
    data['views'] = views;
    data['favorites_number'] = favorites_number;
    data['is_featured'] = is_featured;
    data['price_type'] = price_type;
    data['state'] = state;
    data['title'] = title;
    data['governorate'] = governorate;
    data['address_details'] = address_details;
    data['description'] = description;
    data['phone_number'] = phone_number;
    data['email'] = email;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['final_price'] = final_price;
    return data;
  }

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        added_by: json['added_by'],
        category_id: json['category_id'],
        sub_category_id: json['sub_category_id'],
        price: json['price'],
        views: json['views'],
        favorites_number: json['favorites_number'],
        is_featured: json['is_featured'],
        price_type: json['price_type'],
        state: json['state'],
        title: json['title'],
        governorate: json['governorate'],
        address_details: json['address_details'],
        description: json['description'],
        phone_number: json['phone_number'],
        email: json['email'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        final_price: json['final_price'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'added_by': added_by,
        'category_id': category_id,
        'sub_category_id': sub_category_id,
        'price': price,
        'views': views,
        'favorites_number': favorites_number,
        'is_featured': is_featured,
        'price_type': price_type,
        'state': state,
        'title': title,
        'governorate': governorate,
        'address_details': address_details,
        'description': description,
        'phone_number': phone_number,
        'email': email,
        'created_at': created_at,
        'updated_at': updated_at,
        'final_price': final_price,
      };
}
