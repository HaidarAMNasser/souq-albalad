import 'dart:convert';
// ... inside your ad_details_model.dart file

// Helper function to safely convert any value to a string
String safeString(dynamic value) => value?.toString() ?? '';

class ProductDetailsResponse {
  final int success;
  final ProductResult result;

  ProductDetailsResponse({
    required this.success,
    required this.result,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailsResponse(
        success: json["success"],
        result: ProductResult.fromJson(json["result"]),
      );
}

class ProductResult {
  final List<ProductData> products;

  ProductResult({
    required this.products,
  });

  factory ProductResult.fromJson(Map<String, dynamic> json) => ProductResult(
        products: List<ProductData>.from(
            json["products"].map((x) => ProductData.fromJson(x))),
      );
}

class ProductData {
  final Product product;
  final List<Cost> costs;
  final CategoryInfo category;
  final SubCategoryInfo subCategory;
  final List<String> images;
  final Details details;
  final List<dynamic> reviews;

  ProductData({
    required this.product,
    required this.costs,
    required this.category,
    required this.subCategory,
    required this.images,
    required this.details,
    required this.reviews,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        product: Product.fromJson(json["product"]),
        costs: List<Cost>.from(json["costs"].map((x) => Cost.fromJson(x))),
        category: CategoryInfo.fromJson(json["category"]),
        subCategory: SubCategoryInfo.fromJson(json["subCategory"]),
        images: List<String>.from(json["images"].map((x) => x)),
        details: Details.fromJson(json["details"]),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
      );
}

class Product {
  final int id;
  final String title;
  final String description;
  final String price;
  final String finalPrice;
  final int categoryId;
  final int subCategoryId;
  final int addedBy;
  final String addressDetails;
  final double long;
  final double lat;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String sellerPhone;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.finalPrice,
    required this.categoryId,
    required this.subCategoryId,
    required this.addedBy,
    required this.addressDetails,
    required this.long,
    required this.sellerPhone,
    required this.lat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        // Use .toString() to handle both numbers and strings from the API
        price: safeString(json["price"]),
        finalPrice: safeString(json["final_price"]),
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        addedBy: json["added_by"],
        sellerPhone: safeString(
            json["seller_phone"]), // Also good practice for phone numbers
        addressDetails: json["address_details"],
        long: (json["long"] as num).toDouble(),
        lat: (json["lat"] as num).toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class Cost {
  final int id;
  final num cost;
  final String fromCurrency;
  final String toCurrency;
  final double rate;
  final double costAfterChange;
  final bool isMain;

  Cost({
    required this.id,
    required this.cost,
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.costAfterChange,
    required this.isMain,
  });

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        id: json["id"],
        cost: json["cost"],
        fromCurrency: json["from_currency"],
        toCurrency: json["to_currency"],
        rate: (json["rate"] as num).toDouble(),
        costAfterChange: (json["cost_after_change"] as num).toDouble(),
        isMain: json["is_main"] == 1,
      );
}

class CategoryInfo {
  final int id;
  final String? name;

  CategoryInfo({required this.id, this.name});

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
        id: json["id"],
        name: json["name"],
      );
}

class SubCategoryInfo {
  final int id;
  final String? name;

  SubCategoryInfo({required this.id, this.name});

  factory SubCategoryInfo.fromJson(Map<String, dynamic> json) =>
      SubCategoryInfo(
        id: json["id"],
        name: json["name"],
      );
}

class Details {
  final int id;
  final int productId;
  final String? type;
  final String? brand;
  final String? model;
  final String? color;
  final String? warranty;
  final String? accessories;
  final String? yearOfManufacture;
  final String? sizeOrWeight;
  final String? mainSpecification;
  final String? dimensions;
  final String? storage;
  final String? language;
  final String? author;
  final String? year;
  final String? kilometers;
  final String? fuelType;
  final String? engineCapacity;
  final String? numOfDoors;
  final String? ownership;
  final String? area;
  final String? floor;

  Details({
    required this.id,
    required this.productId,
    this.type,
    this.brand,
    this.model,
    this.color,
    this.warranty,
    this.accessories,
    this.yearOfManufacture,
    this.sizeOrWeight,
    this.mainSpecification,
    this.dimensions,
    this.storage,
    this.language,
    this.author,
    this.year,
    this.kilometers,
    this.fuelType,
    this.engineCapacity,
    this.numOfDoors,
    this.ownership,
    this.area,
    this.floor,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        productId: json["product_id"],
        type: json["type"],
        brand: json["brand"],
        model: json["model"],
        color: json["color"],
        warranty: json["warranty"],
        accessories: json["accessories"],
        yearOfManufacture: json["year_of_manufacture"],
        sizeOrWeight: json["size_or_weight"],
        mainSpecification: json["main_specification"],
        dimensions: json["dimensions"],
        storage: json["storage"],
        language: json["language"],
        author: json["author"],
        year: json["year"],
        kilometers: json["kilometers"],
        fuelType: json["fuel_type"],
        engineCapacity: json["engine_capacity"],
        numOfDoors: json["num_of_doors"],
        ownership: json["ownership"],
        area: json["area"],
        floor: json["floor"],
      );
}
