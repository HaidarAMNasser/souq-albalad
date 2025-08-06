import 'package:souq_al_balad/global/endpoints/core/api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/http_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';

class FavoriteApi {

  Future<ResponseState<MessageModel>> getFavorites() async {
    return API().apiMethod(
      'favorites',
      httpEnum: HttpEnum.get,
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> addToFavorite(int productId) async {
    return API().apiMethod(
      'favorites',
      httpEnum: HttpEnum.post,
      data: {'product_id': productId},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

  Future<ResponseState<MessageModel>> deleteFromFavorite(int favoriteId) async {
    return API().apiMethod(
      'deleteFavorite',
      httpEnum: HttpEnum.post,
      data: {'favorite_id': favoriteId},
      parseJson: (json) => MessageModel.fromJson(json),
    );
  }

}
