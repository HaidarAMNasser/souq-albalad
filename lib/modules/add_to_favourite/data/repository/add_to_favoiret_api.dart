import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/add_to_favourite/data/models/add_to_favoiret_model.dart';

class FavoritesApi {
  final API _api = API();

  Future<ResponseState<AddToFavoriteResponse>> addToFavorites(
      int productId) async {
    const String apiUrl = 'favorites';

    return _api.apiMethod<AddToFavoriteResponse>(
      apiUrl,
      httpEnum: HttpEnum.post,
      data: {
        'product_id': productId,
      },
      parseJson: (json) => AddToFavoriteResponse.fromJson(json),
    );
  }
}
