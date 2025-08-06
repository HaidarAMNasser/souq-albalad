import 'package:flutter/src/widgets/framework.dart';

abstract class HomeEvents {
  const HomeEvents();
}

class LoadDataEvent extends HomeEvents {
  BuildContext context;
  LoadDataEvent(this.context);
}

class GetCategoriesEvent extends HomeEvents {
  BuildContext context;
  GetCategoriesEvent(this.context);
}

class GetFeaturedProductsEvent extends HomeEvents {
  BuildContext context;
  GetFeaturedProductsEvent(this.context);
}

class GetNewestProductsEvent extends HomeEvents {
  BuildContext context;
  GetNewestProductsEvent(this.context);
}

class GetFeaturedStoreEvent extends HomeEvents {
  BuildContext context;
  GetFeaturedStoreEvent(this.context);
}

class GetMoreCategoriesEvent extends HomeEvents {
  BuildContext context;
  GetMoreCategoriesEvent(this.context);
}

class GetProductsByLocationEvent extends HomeEvents {
  int distance;
  double latitude;
  double longitude;
  BuildContext context;

  GetProductsByLocationEvent(this.distance, this.latitude, this.longitude, this.context);
}

class GetOffersEvent extends HomeEvents {
  BuildContext context;
  GetOffersEvent(this.context);
}

class GetServicesEvent extends HomeEvents {
  BuildContext context;
  GetServicesEvent(this.context);
}

class GetJobsEvent extends HomeEvents {
  BuildContext context;
  GetJobsEvent(this.context);
}

class SearchOnProductsEvent extends HomeEvents {
  String? title;
  int? categoryId;
  int? subCategoryId;
  String? minPrice;
  String? maxPrice;
  bool? inside;
  BuildContext? context;

  SearchOnProductsEvent({this.title, this.categoryId, this.subCategoryId,
    this.minPrice,this.maxPrice,this.inside,this.context});
}

class GetUserEvent extends HomeEvents {
  int? id;
  BuildContext context;
  GetUserEvent(this.id,this.context);
}