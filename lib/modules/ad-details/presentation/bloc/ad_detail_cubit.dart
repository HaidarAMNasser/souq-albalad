import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/ad-details/data/models/ad_details_model.dart';
import 'package:souq_al_balad/modules/ad-details/data/repository/ad_details_repository.dart';

part 'ad_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository _productRepository = ProductRepository();

  ProductDetailsCubit() : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(int productId) async {
    emit(ProductDetailsLoading());

    final response = await _productRepository.fetchProductDetails(productId);

    if (response is SuccessState<ProductData>) {
      emit(ProductDetailsSuccess(
        productData: response.data,
        isFavorite: false,
      ));
    } else if (response is ErrorState<ProductData>) {
      emit(
          ProductDetailsFailure(errorMessage: response.errorMessage.getErrors));
    }
  }

  Future<void> toggleFavorite() async {
    if (state is! ProductDetailsSuccess) return;

    final currentState = state as ProductDetailsSuccess;
    final isAddingToFavorites = !currentState.isFavorite;
    final productId = currentState.productData.product.id;

    emit(currentState.copyWith(isFavorite: isAddingToFavorites));

    if (isAddingToFavorites) {
      final response =
          await _productRepository.addProductToFavorites(productId);

      if (response is ErrorState) {
        emit(currentState.copyWith(isFavorite: false));
      }
    } else {}
  }
}
