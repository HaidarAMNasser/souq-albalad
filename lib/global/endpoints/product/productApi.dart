import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';

class ProductApi {

  Future<ResponseState<MessageModel>> getFeaturedProducts() async {
    return API().apiMethod(
      'products?is_featured=1',
      httpEnum: HttpEnum.get,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> getNewestProducts() async {
    return API().apiMethod(
      'products?newest=1',
      httpEnum: HttpEnum.get,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> searchByLocation(int distance, double latitude, double longitude) async {
    return API().apiMethod(
      'search/byLocation',
      httpEnum: HttpEnum.post,
      data: {"distance": distance, "lat": latitude, "long": longitude},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> searchOnProducts(String? title,int? categoryId,
      int? subCategoryId, String? minPrice, String? maxPrice,bool inside) async {
    final Map<String, dynamic> queryParams = {};

    if (title != null && title.isNotEmpty) queryParams['title'] = title;
    if (categoryId != null) queryParams['category_id'] = categoryId.toString();
    if (subCategoryId != null) queryParams['sub_category_id'] = subCategoryId.toString();
    if (minPrice != null) queryParams['price_min'] = minPrice;
    if (maxPrice != null) queryParams['price_max'] = maxPrice;

    final query = Uri(queryParameters: queryParams).query;

    return API().apiMethod(
      'products?$query',
      httpEnum: HttpEnum.get,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

}
