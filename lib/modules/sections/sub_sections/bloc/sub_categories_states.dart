import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/categories/models/sub_category_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';

class SubCategoriesState {
  StateEnum subCategoryState;
  String errorMessage;
  List<CategoryModel>? categories;

  List<SubCategoryModel>? subCategories;
  int selectedIndex;
  SubCategoriesState({
    this.subCategoryState = StateEnum.loading,
    this.errorMessage = '',
    this.categories,
    this.subCategories,
    this.selectedIndex = 0,
  });

  SubCategoriesState copyWith({
    StateEnum? subCategoryState,
    String? errorMessage,
    List<SubCategoryModel>? subCategories,
    List<CategoryModel>? categories,
    int? selectedIndex,
  }) {
    return SubCategoriesState(
      subCategoryState: subCategoryState ?? this.subCategoryState,
      errorMessage: errorMessage ?? this.errorMessage,
      subCategories: subCategories ?? this.subCategories,
      categories: categories ?? this.categories,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
