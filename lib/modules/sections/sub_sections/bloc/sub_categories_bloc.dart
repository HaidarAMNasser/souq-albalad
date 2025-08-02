import 'package:souq_al_balad/global/endpoints/categories/categoriesApi.dart';
import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart'
    show StateEnum;
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/sections/sub_sections/bloc/sub_categories_events.dart';
import 'package:souq_al_balad/modules/sections/sub_sections/bloc/sub_categories_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';

class SubCategoriesBloc extends Bloc<SubCategoriesEvents, SubCategoriesState> {
  SubCategoriesBloc() : super(SubCategoriesState()) {
    on<GetCategoriesEvent>(_getCategoriesEvent);

    on<SetSubCategoriesEvent>(_setSubCategoriesEvent);
  }
  void _getCategoriesEvent(
    GetCategoriesEvent event,
    Emitter<SubCategoriesState> emit,
  ) async {
    emit(state.copyWith(subCategoryState: StateEnum.loading));
    if (event.categories != null) {
      emit(
        state.copyWith(
          categories: event.categories,
          subCategories: event.subCategories,
          selectedIndex: event.selectedIndex,
          subCategoryState: StateEnum.Success,
        ),
      );
    } else {
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
              subCategoryState: StateEnum.Success,
              categories: categories,
              subCategories: categories[0].subCategories,
              selectedIndex: 0,
            ),
          );
        } else {
          emit(
            state.copyWith(
              errorMessage: res.data.message,
              subCategoryState: StateEnum.start,
            ),
          );
          Fluttertoast.showToast(msg: res.data.message);
        }
      } else if (response is ErrorState) {
        ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
        Fluttertoast.showToast(msg: res.errorMessage.error!.message);
        emit(state.copyWith(subCategoryState: StateEnum.start));
      }
    }
  }

  void _setSubCategoriesEvent(
    SetSubCategoriesEvent event,
    Emitter<SubCategoriesState> emit,
  ) async {
    emit(
      state.copyWith(
        subCategories: event.subCategories,
        selectedIndex: event.selectedIndex,
        subCategoryState: StateEnum.Success,
      ),
    );
  }
}
