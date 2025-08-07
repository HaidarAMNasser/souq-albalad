import 'package:souq_al_balad/global/endpoints/models/model.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/ad-details/data/repository/ad_details_api.dart';
import 'package:souq_al_balad/modules/ad-details/data/models/ad_details_model.dart';
import 'package:souq_al_balad/modules/add_to_favourite/data/repository/add_to_favoiret_api.dart';
import 'package:souq_al_balad/modules/add_to_favourite/data/models/add_to_favoiret_model.dart';

class ProductRepository {
  final ProductApi _productApi = ProductApi();
  final FavoritesApi _favoritesApi = FavoritesApi();

  Future<ResponseState<ProductData>> fetchProductDetails(int productId) async {
    try {
      final apiResponse = await _productApi.getProductById(productId);

      if (apiResponse is SuccessState<ProductDetailsResponse>) {
        final productList = apiResponse.data.result.products;

        if (productList.isNotEmpty) {
          return ResponseState.success(productList.first);
        } else {
          return ResponseState.error(
            Model(error: MessageModel(message: 'Product not found.')),
          );
        }
      } else if (apiResponse is ErrorState<ProductDetailsResponse>) {
        return ResponseState.error(apiResponse.errorMessage);
      } else {
        return ResponseState.error(
          Model(
              error: MessageModel(
                  message: 'An unexpected response state was received.')),
        );
      }
    } catch (e, stacktrace) {
      return Model.catchError<ProductData>(e, stacktrace);
    }
  }

  Future<ResponseState<MessageModel>> addProductToFavorites(
      int productId) async {
    try {
      final apiResponse = await _favoritesApi.addToFavorites(productId);

      if (apiResponse is SuccessState<AddToFavoriteResponse>) {
        return ResponseState.success(
          MessageModel(
            success: true,
            message: apiResponse.data.message,
          ),
        );
      } else if (apiResponse is ErrorState<AddToFavoriteResponse>) {
        return ResponseState.error(apiResponse.errorMessage);
      } else {
        return ResponseState.error(
          Model(error: MessageModel(message: 'An unexpected error occurred.')),
        );
      }
    } catch (e, stacktrace) {
      return Model.catchError<MessageModel>(e, stacktrace);
    }
  }
}
