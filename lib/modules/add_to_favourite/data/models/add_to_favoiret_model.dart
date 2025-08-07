class AddToFavoriteResponse {
  final bool success;
  final FavoriteResult result;
  final String message;

  AddToFavoriteResponse({
    required this.success,
    required this.result,
    required this.message,
  });

  factory AddToFavoriteResponse.fromJson(Map<String, dynamic> json) =>
      AddToFavoriteResponse(
        success: json["success"] == 1,
        result: FavoriteResult.fromJson(json["result"]),
        message: json["message"],
      );
}

class FavoriteResult {
  final int favoriteId;

  FavoriteResult({
    required this.favoriteId,
  });

  factory FavoriteResult.fromJson(Map<String, dynamic> json) => FavoriteResult(
        favoriteId: json["favorite_id"],
      );
}