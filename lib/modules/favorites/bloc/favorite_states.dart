import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/favorite/models/favorite_model.dart';

class FavoriteState {
  StateEnum favoritesState;
  StateEnum deleteFromFavoriteState;
  StateEnum addToFavoritesState;
  String errorMessage;
  List<FavoriteModel>? favorites;
  int? deletingFavoriteId;


  FavoriteState({
    this.favoritesState = StateEnum.loading,
    this.deleteFromFavoriteState = StateEnum.start,
    this.addToFavoritesState = StateEnum.start,
    this.errorMessage = '',
    this.favorites,
    this.deletingFavoriteId
  });

  FavoriteState copyWith({
    StateEnum? favoritesState,
    StateEnum? deleteFromFavoriteState,
    StateEnum? addToFavoritesState,
    String? errorMessage,
    List<FavoriteModel>? favorites,
    int? deletingFavoriteId,
  }) {
    return FavoriteState(
      favoritesState: favoritesState ?? this.favoritesState,
      deleteFromFavoriteState: deleteFromFavoriteState ?? this.deleteFromFavoriteState,
      addToFavoritesState: addToFavoritesState ?? this.addToFavoritesState,
      errorMessage: errorMessage ?? this.errorMessage,
      favorites: favorites ?? this.favorites,
      deletingFavoriteId: deletingFavoriteId ?? this.deletingFavoriteId,
    );
  }
}
