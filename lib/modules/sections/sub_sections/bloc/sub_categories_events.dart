import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/categories/models/sub_category_model.dart';
import 'package:flutter/src/widgets/framework.dart';

abstract class SubCategoriesEvents {
  const SubCategoriesEvents();
}

class GetCategoriesEvent extends SubCategoriesEvents {
  List<SubCategoryModel>? subCategories;
  List<CategoryModel>? categories;
  int selectedIndex;

  BuildContext context;
  GetCategoriesEvent(
    this.categories,
    this.subCategories,
    this.selectedIndex,
    this.context,
  );
}

class SetSubCategoriesEvent extends SubCategoriesEvents {
  BuildContext context;
  List<SubCategoryModel>? subCategories;
  int selectedIndex;
  SetSubCategoriesEvent(this.subCategories, this.selectedIndex, this.context);
}
