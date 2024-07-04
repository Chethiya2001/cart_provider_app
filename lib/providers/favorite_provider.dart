import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  //sate
  Map<String, bool> _favorites = {};
  //getter
  Map<String, bool> get favorites => _favorites;

  //add favorite and toggle
  void toggleFavorite(String productId) {
    if (_favorites.containsKey(productId)) {
      _favorites[productId] = !_favorites[productId]!;
    } else {
      _favorites[productId] = true;
    }
    notifyListeners();

  }
  //check favorite or not
  bool isFavorite(String productId) {
    return _favorites[productId] ?? false;
  }
}
