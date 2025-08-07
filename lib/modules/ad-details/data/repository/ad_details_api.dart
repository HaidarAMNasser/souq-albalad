import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/ad-details/data/models/ad_details_model.dart';
import 'package:souq_al_balad/modules/stores/data/models/get_stores_model.dart';
import 'package:souq_al_balad/modules/stores/data/repository/get_stores_repo.dart';

class ProductApi {
  final API _api = API();

  Future<ResponseState<ProductDetailsResponse>> getProductById(
      int productId) async {
    const String apiUrl = 'products';

    return _api.apiMethod<ProductDetailsResponse>(
      apiUrl,
      httpEnum: HttpEnum.get,
      queryParameters: {'id': productId},
      parseJson: (json) => ProductDetailsResponse.fromJson(json),
    );
  }
} // lib/modules/stores/logic/store_details_state.dart
