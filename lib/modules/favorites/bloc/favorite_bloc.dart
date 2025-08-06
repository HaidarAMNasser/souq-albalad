import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart' show StateEnum;
import 'package:souq_al_balad/global/endpoints/favorite/favoriteApi.dart';
import 'package:souq_al_balad/global/endpoints/favorite/models/favorite_model.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/favorites/bloc/favorite_events.dart';
import 'package:souq_al_balad/modules/favorites/bloc/favorite_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteBloc extends Bloc<FavoritesEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState()) {
    on<GetFavoritesEvent>(_getFavoritesEvent);
    on<AddToFavoriteEvent>(_addToFavoriteEvent);
    on<DeleteFromFavoriteEvent>(_deleteFromFavoriteEvent);
  }

  void _getFavoritesEvent(GetFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(favoritesState: StateEnum.loading));
    ResponseState<MessageModel> response = await FavoriteApi().getFavorites();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        List<FavoriteModel> products = [];
        for (var i = 0; i < res.data.result['favorites'].length; i++) {
          FavoriteModel product = FavoriteModel.fromJson(
            res.data.result['favorites'][i],
          );
          products.add(product);
        }
        emit(state.copyWith(favoritesState: StateEnum.Success, favorites: products));
      } else {
        emit(state.copyWith(errorMessage: res.data.message, favoritesState: StateEnum.start));
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(favoritesState: StateEnum.start));
    }
  }

  void _addToFavoriteEvent(AddToFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(addToFavoritesState: StateEnum.loading));
    ResponseState<MessageModel> response = await FavoriteApi().addToFavorite(event.productId);
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        emit(state.copyWith(addToFavoritesState: StateEnum.start));
      } else {
        emit(
          state.copyWith(errorMessage: res.data.message,addToFavoritesState: StateEnum.start),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(addToFavoritesState: StateEnum.start));
    }
  }

  void _deleteFromFavoriteEvent(DeleteFromFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(deleteFromFavoriteState: StateEnum.loading,deletingFavoriteId: event.favoriteId));
    ResponseState<MessageModel> response = await FavoriteApi().deleteFromFavorite(event.favoriteId);
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        add(GetFavoritesEvent(event.context));
        emit(state.copyWith(deleteFromFavoriteState: StateEnum.start));
      } else {
        emit(
          state.copyWith(errorMessage: res.data.message,deleteFromFavoriteState: StateEnum.start,deletingFavoriteId: null),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(deleteFromFavoriteState: StateEnum.start,deletingFavoriteId: null));
    }
  }
}
