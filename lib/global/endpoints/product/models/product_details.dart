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
      deviceType: json['device_type'],
      type: json['type'],
      brand: json['brand'],
      model: json['model'],
      madeIn: json['made_in'],
      yearOfManufacture: json['year_of_manufacture'],
      screenSize: json['screen_size'],
      warranty: json['warranty'],
      accessories: json['accessories'],
      camera: json['camera'],
      storage: json['storage'],
      color: json['color'],
      supportsSim: json['supports_sim'],
      operationSystem: json['operation_system'],
      screenCard: json['screen_card'],
      ram: json['ram'],
      processor: json['processor'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
