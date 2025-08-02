import 'package:souq_al_balad/global/endpoints/product/models/product_model.dart';
import 'package:souq_al_balad/global/endpoints/store/models/store_model.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart';

class StoreBundleModel {
  StoreModel? store;
  UserModel? user;
  List<ProductModel>? products;

  StoreBundleModel({this.store, this.user, this.products});

  factory StoreBundleModel.fromJson(Map<String, dynamic> json) {
    return StoreBundleModel(
      store: json['store'] != null ? StoreModel.fromJson(json['store']) : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      products:
          json['products'] != null
              ? List<ProductModel>.from(
                json['products'].map((x) => ProductModel.fromJson(x)),
              )
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (store != null) data['store'] = store!.toJson();
    if (user != null) data['user'] = user!.toJson();
    data['products'] = products?.map((x) => x.toJson()).toList() ?? [];
    return data;
  }
}
