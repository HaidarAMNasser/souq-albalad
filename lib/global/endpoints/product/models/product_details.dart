class ProductDetailsModel {
  int? id;
  int? productId;
  String? deviceType;
  String? type;
  String? brand;
  String? model;
  String? madeIn;
  String? yearOfManufacture;
  String? screenSize;
  String? warranty;
  String? accessories;
  String? camera;
  String? storage;
  String? color;
  String? supportsSim;
  String? operationSystem;
  String? screenCard;
  String? ram;
  String? processor;
  String? createdAt;
  String? updatedAt;

  ProductDetailsModel({
    this.id,
    this.productId,
    this.deviceType,
    this.type,
    this.brand,
    this.model,
    this.madeIn,
    this.yearOfManufacture,
    this.screenSize,
    this.warranty,
    this.accessories,
    this.camera,
    this.storage,
    this.color,
    this.supportsSim,
    this.operationSystem,
    this.screenCard,
    this.ram,
    this.processor,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      productId: json['product_id'],
      deviceType: json['device_type']?.toString(),
      type: json['type']?.toString(),
      brand: json['brand']?.toString(),
      model: json['model']?.toString(),
      madeIn: json['made_in']?.toString(),
      yearOfManufacture: json['year_of_manufacture']?.toString(),
      screenSize: json['screen_size']?.toString(),
      warranty: json['warranty']?.toString(),
      accessories: json['accessories']?.toString(),
      camera: json['camera']?.toString(),
      storage: json['storage']?.toString(),
      color: json['color']?.toString(),
      supportsSim: json['supports_sim']?.toString(),
      operationSystem: json['operation_system']?.toString(),
      screenCard: json['screen_card']?.toString(),
      ram: json['ram']?.toString(),
      processor: json['processor']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['device_type'] = deviceType;
    data['type'] = type;
    data['brand'] = brand;
    data['model'] = model;
    data['made_in'] = madeIn;
    data['year_of_manufacture'] = yearOfManufacture;
    data['screen_size'] = screenSize;
    data['warranty'] = warranty;
    data['accessories'] = accessories;
    data['camera'] = camera;
    data['storage'] = storage;
    data['color'] = color;
    data['supports_sim'] = supportsSim;
    data['operation_system'] = operationSystem;
    data['screen_card'] = screenCard;
    data['ram'] = ram;
    data['processor'] = processor;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
