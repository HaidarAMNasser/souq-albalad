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