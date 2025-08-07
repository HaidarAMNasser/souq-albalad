import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/product/models/product_bundle.dart';
import 'package:souq_al_balad/global/endpoints/search_by_location/models/location_model.dart';
import 'package:souq_al_balad/global/endpoints/store/models/store_bundle_model.dart';

class HomeState {
  StateEnum categoryState;
  StateEnum featuredProductsState;
  StateEnum newestProductsState;
  StateEnum featuredStoresState;
  StateEnum productsByLocationState;
  String errorMessage;
  List<CategoryModel>? categories;
  List<ProductBundleModel>? featuredProducts;
  List<ProductBundleModel>? newestProducts;
  List<StoreBundleModel>? featuredStores;
  List<LocationModel>? productsByLocation;
  bool moreCategoriesClicked;
  HomeState({
    this.categoryState = StateEnum.loading,
    this.featuredProductsState = StateEnum.loading,
    this.newestProductsState = StateEnum.loading,
    this.featuredStoresState = StateEnum.loading,
    this.productsByLocationState = StateEnum.start,
    this.errorMessage = '',
    this.categories,
    this.featuredProducts,
    this.newestProducts,
    this.featuredStores,
    this.productsByLocation,
    this.moreCategoriesClicked = false,
  });

  HomeState copyWith({
    StateEnum? categoryState,
    StateEnum? featuredProductsState,
    StateEnum? newestProductsState,
    StateEnum? featuredStoresState,
    StateEnum? productsByLocationState,
    String? errorMessage,
    List<CategoryModel>? categories,
    List<ProductBundleModel>? featuredProducts,
    List<ProductBundleModel>? newestProducts,
    List<StoreBundleModel>? featuredStores,
    List<LocationModel>? productsByLocation,
    bool? moreCategoriesClicked,
  }) {
    return HomeState(
      categoryState: categoryState ?? this.categoryState,
      featuredProductsState:
          featuredProductsState ?? this.featuredProductsState,
      newestProductsState: newestProductsState ?? this.newestProductsState,
      featuredStoresState: featuredStoresState ?? this.featuredStoresState,
      productsByLocationState:
          productsByLocationState ?? this.productsByLocationState,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      newestProducts: newestProducts ?? this.newestProducts,
      featuredStores: featuredStores ?? this.featuredStores,
      productsByLocation: productsByLocation ?? this.productsByLocation,
      moreCategoriesClicked:
          moreCategoriesClicked ?? this.moreCategoriesClicked,
    );
  }
}
