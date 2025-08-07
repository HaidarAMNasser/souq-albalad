String safeString(dynamic value) => value?.toString() ?? '';

// Safely parse dynamic values to a non-nullable double, defaulting to 0.0.
double safeDouble(dynamic value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

// Safely parse dynamic values to a non-nullable int, defaulting to 0.
int safeInt(dynamic value) {
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

// Safely parse a date string into a nullable DateTime object.
DateTime? safeDateTimeParse(String? dateString) {
  if (dateString == null) return null;
  return DateTime.tryParse(dateString);
}

// --- DATA MODELS ---

// Top-level response object
class StoresResponse {
  final int success;
  final StoreResult? result; // Made nullable for safety
  final String message;

  StoresResponse({
    required this.success,
    this.result,
    required this.message,
  });

  factory StoresResponse.fromJson(Map<String, dynamic> json) => StoresResponse(
        success: safeInt(json["success"]),
        // Check if result is null before parsing
        result: json["result"] == null
            ? null
            : StoreResult.fromJson(json["result"]),
        message: safeString(json["message"]),
      );
}

// Result object containing the list of stores
class StoreResult {
  final List<StoreData> stores;

  StoreResult({
    required this.stores,
  });

  factory StoreResult.fromJson(Map<String, dynamic> json) => StoreResult(
        // Handle null or missing 'stores' key by providing an empty list
        stores: json["stores"] == null
            ? []
            : List<StoreData>.from(
                json["stores"].map((x) => StoreData.fromJson(x))),
      );
}

// Main data object for a single store
class StoreData {
  final StoreInfo? store; // Made nullable
  final UserInfo? user; // Made nullable
  final List<StoreProduct> products;

  StoreData({
    this.store,
    this.user,
    required this.products,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) => StoreData(
        store: json["store"] == null ? null : StoreInfo.fromJson(json["store"]),
        user: json["user"] == null ? null : UserInfo.fromJson(json["user"]),
        // Handle null or missing 'products' key by providing an empty list
        products: json["products"] == null
            ? []
            : List<StoreProduct>.from(
                json["products"].map((x) => StoreProduct.fromJson(x))),
      );
}

// Store-specific information
class StoreInfo {
  final int id;
  final String storeOwnerName;
  final String storeName;
  final String address;
  final String? logo;
  final String? cover;
  final String phone;
  final String description;
  final bool isFeatured;
  final DateTime? createdAt; // Made nullable
  final DateTime? updatedAt; // Made nullable

  StoreInfo({
    required this.id,
    required this.storeOwnerName,
    required this.storeName,
    required this.address,
    this.logo,
    this.cover,
    required this.phone,
    required this.description,
    required this.isFeatured,
    this.createdAt,
    this.updatedAt,
  });

  factory StoreInfo.fromJson(Map<String, dynamic> json) => StoreInfo(
        id: safeInt(json["id"]),
        storeOwnerName: safeString(json["store_owner_name"]),
        storeName: safeString(json["store_name"]),
        address: safeString(json["address"]),
        logo: json["logo"],
        cover: json["cover"],
        phone: safeString(json["phone"]),
        description: safeString(json["description"]),
        isFeatured: json["is_featured"] == 1,
        createdAt: safeDateTimeParse(json["created_at"]),
        updatedAt: safeDateTimeParse(json["updated_at"]),
      );
}

// User (owner) information
class UserInfo {
  final int id;
  final String name;
  final String email;
  final String phone;
  final int? age;
  final DateTime? emailVerifiedAt;
  final String? provider;
  final String? status;
  final String? providerId;
  final String? firebaseToken;
  final DateTime? createdAt; // Made nullable
  final DateTime? updatedAt; // Made nullable
  final bool isActive;
  final DateTime? deletedAt;
  final String? profileImage;

  UserInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.age,
    this.emailVerifiedAt,
    this.provider,
    this.status,
    this.providerId,
    this.firebaseToken,
    this.createdAt,
    this.updatedAt,
    required this.isActive,
    this.deletedAt,
    this.profileImage,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: safeInt(json["id"]),
        name: safeString(json["name"]),
        email: safeString(json["email"]),
        phone: safeString(json["phone"]),
        age: json["age"], // Already nullable, no change needed
        emailVerifiedAt: safeDateTimeParse(json["email_verified_at"]),
        provider: json["provider"],
        status: json["status"],
        providerId: json["provider_id"],
        firebaseToken: json["firebase_token"],
        createdAt: safeDateTimeParse(json["created_at"]),
        updatedAt: safeDateTimeParse(json["updated_at"]),
        isActive: json["is_active"] == 1,
        deletedAt: safeDateTimeParse(json["deleted_at"]),
        profileImage: json["profile_image"],
      );
}

// Product information, specific to the store's product list
class StoreProduct {
  final int id;
  final int addedBy;
  final String title;
  final int categoryId;
  final int subCategoryId;
  final String price;
  final int views;
  final int favoritesNumber;
  final bool isFeatured;
  final String priceType;
  final String state;
  final String governorate;
  final String addressDetails;
  final double long;
  final double lat;
  final String description;
  final String phoneNumber;
  final String email;
  final DateTime? createdAt; // Made nullable
  final DateTime? updatedAt; // Made nullable
  final bool isActive;
  final String finalPrice;
  final String sellerPhone;
  final Category? category;
  final SubCategory? subCategory;

  StoreProduct({
    required this.id,
    required this.addedBy,
    required this.title,
    required this.categoryId,
    required this.subCategoryId,
    required this.price,
    required this.views,
    required this.favoritesNumber,
    required this.isFeatured,
    required this.priceType,
    required this.state,
    required this.governorate,
    required this.addressDetails,
    required this.long,
    required this.lat,
    required this.description,
    required this.phoneNumber,
    required this.email,
    this.createdAt,
    this.updatedAt,
    required this.isActive,
    required this.finalPrice,
    required this.sellerPhone,
    this.category,
    this.subCategory,
  });

  factory StoreProduct.fromJson(Map<String, dynamic> json) => StoreProduct(
        id: safeInt(json["id"]),
        addedBy: safeInt(json["added_by"]),
        title: safeString(json["title"]),
        categoryId: safeInt(json["category_id"]),
        subCategoryId: safeInt(json["sub_category_id"]),
        price: safeString(json["price"]),
        views: safeInt(json["views"]),
        favoritesNumber: safeInt(json["favorites_number"]),
        isFeatured: json["is_featured"] == 1,
        priceType: safeString(json["price_type"]),
        state: safeString(json["state"]),
        governorate: safeString(json["governorate"]),
        addressDetails: safeString(json["address_details"]),
        long: safeDouble(json["long"]),
        lat: safeDouble(json["lat"]),
        description: safeString(json["description"]),
        phoneNumber: safeString(json["phone_number"]),
        email: safeString(json["email"]),
        createdAt: safeDateTimeParse(json["created_at"]),
        updatedAt: safeDateTimeParse(json["updated_at"]),
        isActive: json["is_active"] == 1,
        finalPrice: safeString(json["final_price"]),
        sellerPhone: safeString(json["seller_phone"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        subCategory: json["sub_category"] == null
            ? null
            : SubCategory.fromJson(json["sub_category"]),
      );
}

// Reusable Category model
class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: safeInt(json["id"]),
        name: safeString(json["name"]),
      );
}

// Reusable SubCategory model
class SubCategory {
  final int id;
  final String name;

  SubCategory({required this.id, required this.name});

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: safeInt(json["id"]),
        name: safeString(json["name"]),
      );
}
