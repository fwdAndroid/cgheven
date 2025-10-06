import 'package:flutter/material.dart';
import 'package:cgheven/model/asset_model.dart';

class FavouriteProvider with ChangeNotifier {
  final List<AssetModel> _favourites = [];

  List<AssetModel> get favourites => _favourites;

  bool isFavourite(AssetModel asset) {
    return _favourites.any((a) => a.id == asset.id);
  }

  void toggleFavourite(AssetModel asset) {
    if (isFavourite(asset)) {
      _favourites.removeWhere((a) => a.id == asset.id);
    } else {
      _favourites.add(asset);
    }
    notifyListeners();
  }
}
