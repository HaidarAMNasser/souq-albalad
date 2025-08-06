import 'package:flutter/material.dart';

abstract class FavoritesEvent {

  const FavoritesEvent();
}

class GetFavoritesEvent extends FavoritesEvent {
  BuildContext context;
  GetFavoritesEvent(this.context);
}

class AddToFavoriteEvent extends FavoritesEvent {
  int productId;
  BuildContext context;

  AddToFavoriteEvent(this.productId, this.context);
}

class DeleteFromFavoriteEvent extends FavoritesEvent {
  int favoriteId;
  BuildContext context;

  DeleteFromFavoriteEvent(this.favoriteId, this.context);
}
