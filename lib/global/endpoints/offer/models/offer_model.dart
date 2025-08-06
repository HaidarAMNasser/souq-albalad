import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/product/models/product_model.dart';

class OfferModel {
  int? id;
  String? type;
  String? description;
  int? discount;
  String? image;
  OfferOn? on;

  OfferModel({
    this.id,
    this.type,
    this.description,
    this.discount,
    this.image,
    this.on,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      type: json['type'],
      description: json['description'],
      discount: json['discount'],
      image: json['image'],
      on: OfferOn.fromJson(json['on']),
    );
  }
}

class OfferOn {
  String? type;
  dynamic data;

  OfferOn({this.type, this.data});

  factory OfferOn.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    final rawData = json['data'];

    return OfferOn(
      type: type,
      data: type == 'Product'
          ? ProductModel.fromJson(rawData)
          : CategoryModel.fromJson(rawData),
    );
  }
}
