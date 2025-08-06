import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/job/models/job_model.dart';
import 'package:souq_al_balad/global/endpoints/offer/models/offer_model.dart';
import 'package:souq_al_balad/global/endpoints/product/models/product_bundle.dart';
import 'package:souq_al_balad/global/endpoints/product/models/location_model.dart';
import 'package:souq_al_balad/global/endpoints/seller/models/seller_model.dart';
import 'package:souq_al_balad/global/endpoints/service/models/service_model.dart';
import 'package:souq_al_balad/global/endpoints/store/models/store_bundle_model.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart';

class HomeState {
  StateEnum categoryState;
  StateEnum featuredProductsState;
  StateEnum newestProductsState;
  StateEnum featuredStoresState;
  StateEnum offersState;
  StateEnum servicesState;
  StateEnum jobsState;
  StateEnum productsByLocationState;
  StateEnum searchOnProductsState;
  StateEnum getUserState;
  String errorMessage;
  List<CategoryModel>? categories;
  List<ProductBundleModel>? featuredProducts;
  List<ProductBundleModel>? newestProducts;
  List<StoreBundleModel>? featuredStores;
  List<OfferModel>? offers;
  List<ServiceModel>? services;
  List<JobModel>? jobs;
  List<LocationModel>? productsByLocation;
  List<ProductBundleModel>? products;
  bool moreCategoriesClicked;
  UserModel? user;

  HomeState({
    this.categoryState = StateEnum.loading,
    this.featuredProductsState = StateEnum.loading,
    this.newestProductsState = StateEnum.loading,
    this.featuredStoresState = StateEnum.loading,
    this.offersState = StateEnum.loading,
    this.servicesState = StateEnum.loading,
    this.jobsState = StateEnum.loading,
    this.productsByLocationState = StateEnum.start,
    this.searchOnProductsState = StateEnum.start,
    this.getUserState = StateEnum.loading,
    this.errorMessage = '',
    this.categories,
    this.featuredProducts,
    this.newestProducts,
    this.featuredStores,
    this.offers,
    this.services,
    this.jobs,
    this.productsByLocation,
    this.products,
    this.moreCategoriesClicked = false,
    this.user
  });

  HomeState copyWith({
    StateEnum? categoryState,
    StateEnum? featuredProductsState,
    StateEnum? newestProductsState,
    StateEnum? featuredStoresState,
    StateEnum? offersState,
    StateEnum? servicesState,
    StateEnum? jobsState,
    StateEnum? productsByLocationState,
    StateEnum? searchOnProductsState,
    StateEnum? getUserState,
    String? errorMessage,
    List<CategoryModel>? categories,
    List<ProductBundleModel>? featuredProducts,
    List<ProductBundleModel>? newestProducts,
    List<StoreBundleModel>? featuredStores,
    List<OfferModel>? offers,
    List<ServiceModel>? services,
    List<JobModel>? jobs,
    List<LocationModel>? productsByLocation,
    List<ProductBundleModel>? products,
    bool? moreCategoriesClicked,
    UserModel? user,
  }) {
    return HomeState(
      categoryState: categoryState ?? this.categoryState,
      featuredProductsState:
          featuredProductsState ?? this.featuredProductsState,
      newestProductsState: newestProductsState ?? this.newestProductsState,
      featuredStoresState: featuredStoresState ?? this.featuredStoresState,
      offersState: offersState ?? this.offersState,
      servicesState: servicesState ?? this.servicesState,
      jobsState: jobsState ?? this.jobsState,
      productsByLocationState: productsByLocationState ?? this.productsByLocationState,
      searchOnProductsState: searchOnProductsState ?? this.searchOnProductsState,
      getUserState: getUserState ?? this.getUserState,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      newestProducts: newestProducts ?? this.newestProducts,
      featuredStores: featuredStores ?? this.featuredStores,
      offers: offers ?? this.offers,
      services: services ?? this.services,
      jobs: jobs ?? this.jobs,
      productsByLocation: productsByLocation ?? this.productsByLocation,
      products: products ?? this.products,
      moreCategoriesClicked: moreCategoriesClicked ?? this.moreCategoriesClicked,
      user: user ?? this.user,
    );
  }
}
