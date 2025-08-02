import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';

class CategoriesState {
  StateEnum categoryState;
  String errorMessage;
  List<CategoryModel>? categories;
  CategoriesState({
    this.categoryState = StateEnum.loading,
    this.errorMessage = '',
    this.categories,
  });

  CategoriesState copyWith({
    StateEnum? categoryState,
    String? errorMessage,
    List<CategoryModel>? categories,
  }) {
    return CategoriesState(
      categoryState: categoryState ?? this.categoryState,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
    );
  }
}
