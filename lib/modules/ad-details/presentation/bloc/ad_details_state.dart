part of 'ad_detail_cubit.dart';


abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();
  @override
  List<Object> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final ProductData productData;
  final bool isFavorite;

  const ProductDetailsSuccess(
      {required this.productData, required this.isFavorite});

  ProductDetailsSuccess copyWith({
    ProductData? productData,
    bool? isFavorite,
  }) {
    return ProductDetailsSuccess(
      productData: productData ?? this.productData,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [productData, isFavorite];
}

class ProductDetailsFailure extends ProductDetailsState {
  final String errorMessage;
  const ProductDetailsFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}