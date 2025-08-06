import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter, BlocProvider;
import 'package:souq_al_balad/global/endpoints/categories/categoriesApi.dart';
import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart' show StateEnum;
import 'package:souq_al_balad/global/endpoints/job/jobApi.dart';
import 'package:souq_al_balad/global/endpoints/job/models/job_model.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/global/endpoints/offer/models/offer_model.dart';
import 'package:souq_al_balad/global/endpoints/offer/offerApi.dart';
import 'package:souq_al_balad/global/endpoints/product/models/product_bundle.dart';
import 'package:souq_al_balad/global/endpoints/product/productApi.dart';
import 'package:souq_al_balad/global/endpoints/product/models/location_model.dart';
import 'package:souq_al_balad/global/endpoints/service/models/service_model.dart';
import 'package:souq_al_balad/global/endpoints/service/serviceApi.dart';
import 'package:souq_al_balad/global/endpoints/store/models/store_bundle_model.dart';
import 'package:souq_al_balad/global/endpoints/store/storeApi.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart';
import 'package:souq_al_balad/global/endpoints/user/userApi.dart';
import 'package:souq_al_balad/modules/home/bloc/home_events.dart';
import 'package:souq_al_balad/modules/home/bloc/home_states.dart';
import 'package:souq_al_balad/modules/home/view/screen/search_results_by_location_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:souq_al_balad/modules/home/view/screen/search_results_screen.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<GetCategoriesEvent>(_getCategoriesEvent);
    on<GetFeaturedProductsEvent>(_getFeaturedProductsEvent);
    on<GetNewestProductsEvent>(_getNewestProductsEvent);
    on<GetFeaturedStoreEvent>(_getFeaturedStoreEvent);
    on<GetOffersEvent>(_getOffersEvent);
    on<GetMoreCategoriesEvent>(_getMoreCategories);
    on<GetProductsByLocationEvent>(_getProductsByLocation);
    on<GetServicesEvent>(_getServicesEvent);
    on<GetJobsEvent>(_getJobsEvent);
    on<SearchOnProductsEvent>(_getProductsEvent);
    on<GetUserEvent>(_getSellerEvent);
  }

  void _getCategoriesEvent(
    GetCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(categoryState: StateEnum.loading));
    ResponseState<MessageModel> response =
        await CategoriesApi().getCategories();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<CategoryModel> categories = [];
        for (var i = 0; i < res.data.result.length; i++) {
          CategoryModel category = CategoryModel.fromJson(res.data.result[i]);
          categories.add(category);
        }

        emit(
          state.copyWith(
            categoryState: StateEnum.Success,
            categories: categories,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            categoryState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(categoryState: StateEnum.start));
    }
  }

  void _getFeaturedProductsEvent(
    GetFeaturedProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(featuredProductsState: StateEnum.loading));
    ResponseState<MessageModel> response =
        await ProductApi().getFeaturedProducts();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<ProductBundleModel> products = [];
        for (var i = 0; i < res.data.result['products'].length; i++) {
          ProductBundleModel product = ProductBundleModel.fromJson(
            res.data.result['products'][i],
          );
          products.add(product);
        }

        emit(
          state.copyWith(
            featuredProductsState: StateEnum.Success,
            featuredProducts: products,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            featuredProductsState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(featuredProductsState: StateEnum.start));
    }
  }

  void _getNewestProductsEvent(
    GetNewestProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(newestProductsState: StateEnum.loading));
    ResponseState<MessageModel> response =
        await ProductApi().getNewestProducts();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<ProductBundleModel> products = [];
        for (var i = 0; i < res.data.result['products'].length; i++) {
          ProductBundleModel product = ProductBundleModel.fromJson(
            res.data.result['products'][i],
          );
          products.add(product);
        }

        emit(
          state.copyWith(
            newestProductsState: StateEnum.Success,
            newestProducts: products,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            newestProductsState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(newestProductsState: StateEnum.start));
    }
  }

  void _getFeaturedStoreEvent(
    GetFeaturedStoreEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(featuredStoresState: StateEnum.loading));
    ResponseState<MessageModel> response = await StoreApi().getStores();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<StoreBundleModel> stores = [];
        for (var i = 0; i < res.data.result['stores'].length; i++) {
          StoreBundleModel store = StoreBundleModel.fromJson(
            res.data.result['stores'][i],
          );
          stores.add(store);
        }

        emit(
          state.copyWith(
            featuredStoresState: StateEnum.Success,
            featuredStores: stores,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            featuredStoresState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(featuredProductsState: StateEnum.start));
    }
  }

  FutureOr<void> _getMoreCategories(
    GetMoreCategoriesEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(moreCategoriesClicked: true));
  }

  void _getProductsByLocation(
    GetProductsByLocationEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(productsByLocationState: StateEnum.loading));
    ResponseState<MessageModel> response = await ProductApi()
        .searchByLocation(event.distance, event.latitude, event.longitude);
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<LocationModel> productsByLocation = [];
        for (var i = 0; i < res.data.result.length; i++) {
          LocationModel location = LocationModel.fromJson(res.data.result[i]);
          productsByLocation.add(location);
        }
        Get.to(() => SearchResultsByLocationScreen(products: productsByLocation));
        emit(
          state.copyWith(
            productsByLocationState: StateEnum.Success,
            productsByLocation: productsByLocation,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            productsByLocationState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(productsByLocationState: StateEnum.start));
    }
  }

  void _getOffersEvent(GetOffersEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(offersState: StateEnum.loading));
    ResponseState<MessageModel> response = await OfferApi().getOffers();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<OfferModel> offers = [];
        for (var i = 0; i < res.data.result["offers"].length; i++) {
          OfferModel offer = OfferModel.fromJson(res.data.result["offers"][i]);
          offers.add(offer);
        }
        emit(state.copyWith(offersState: StateEnum.Success, offers: offers));
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            offersState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(offersState: StateEnum.start));
    }
  }

  void _getServicesEvent(GetServicesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(servicesState: StateEnum.loading));
    ResponseState<MessageModel> response = await ServiceApi().getServices();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<ServiceModel> services = [];
        for (var i = 0; i < res.data.result.length; i++) {
          ServiceModel service = ServiceModel.fromJson(res.data.result[i]);
          services.add(service);
        }
        emit(state.copyWith(servicesState: StateEnum.Success, services: services));
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            servicesState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(servicesState: StateEnum.start));
    }
  }

  void _getJobsEvent(GetJobsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(jobsState: StateEnum.loading));
    ResponseState<MessageModel> response = await JobApi().getJobs();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<JobModel> jobs = [];
        for (var i = 0; i < res.data.result.length; i++) {
          JobModel job = JobModel.fromJson(res.data.result[i]);
          jobs.add(job);
        }
        emit(state.copyWith(jobsState: StateEnum.Success, jobs: jobs));
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            jobsState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(jobsState: StateEnum.start));
    }
  }

  void _getProductsEvent(SearchOnProductsEvent event,Emitter<HomeState> emit) async {
    emit(state.copyWith(searchOnProductsState: StateEnum.loading));
    ResponseState<MessageModel> response = await ProductApi()
        .searchOnProducts(event.title, event.categoryId, event.subCategoryId,
      event.minPrice,event.maxPrice,event.inside!);
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<ProductBundleModel> products = [];
        for (var i = 0; i < res.data.result['products'].length; i++) {
          ProductBundleModel product = ProductBundleModel.fromJson(
            res.data.result['products'][i],
          );
          products.add(product);
        }
        emit(state.copyWith(searchOnProductsState: StateEnum.Success, products: products));
        if (event.inside == true) {
          Future.delayed(Duration(milliseconds: 100), () {
            Navigator.of(event.context!).pop();
          });
        } else {
          Get.to(() => BlocProvider.value(
            value: BlocProvider.of<HomeBloc>(event.context!),
            child: SearchResultsScreen(title: event.title ?? ""),
          ));
        }
      } else {
        emit(state.copyWith(errorMessage: res.data.message, searchOnProductsState: StateEnum.start));
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(searchOnProductsState: StateEnum.start));
    }
  }

  void _getSellerEvent(GetUserEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(getUserState: StateEnum.loading));
    ResponseState<MessageModel> response = await UserApi().getUser(event.id!);
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        UserModel user = UserModel.fromJson(
          res.data.result["user"],
        );
        emit(state.copyWith(getUserState: StateEnum.Success, user: user));
      } else {
        emit(state.copyWith(errorMessage: res.data.message, getUserState: StateEnum.start));
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(getUserState: StateEnum.start));
    }
  }
}
