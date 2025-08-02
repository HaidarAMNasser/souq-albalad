import 'package:souq_al_balad/global/endpoints/categories/categoriesApi.dart';
import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart'
    show StateEnum;
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/sections/bloc/categories_events.dart';
import 'package:souq_al_balad/modules/sections/bloc/categories_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';

class CategoriesBloc extends Bloc<CategoriesEvents, CategoriesState> {
  CategoriesBloc() : super(CategoriesState()) {
    on<GetCategoriesEvent>(_getCategoriesEvent);
  }

  void _getCategoriesEvent(
    GetCategoriesEvent event,
    Emitter<CategoriesState> emit,
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
}
