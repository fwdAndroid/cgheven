import 'dart:convert';

import 'package:cgheven/model/asset_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteProvider with ChangeNotifier {
  final List<AssetModel> _favourites = [];

  List<AssetModel> get favourites => _favourites;

  FavouriteProvider() {
    loadFavourites(); // automatically load on provider init
  }

  Future<void> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final favJsonList = prefs.getStringList('favourites') ?? [];

    _favourites.clear();
    for (final jsonString in favJsonList) {
      try {
        final data = json.decode(jsonString);
        _favourites.add(AssetModel.fromJson(data));
      } catch (e) {
        debugPrint("❌ Error loading favourite: $e");
      }
    }
    notifyListeners();
  }

  bool isFavourite(AssetModel asset) {
    return _favourites.any((a) => a.id == asset.id);
  }

  Future<void> toggleFavourite(AssetModel asset) async {
    final prefs = await SharedPreferences.getInstance();

    if (isFavourite(asset)) {
      _favourites.removeWhere((a) => a.id == asset.id);
    } else {
      _favourites.add(asset);
    }

    final favJsonList = _favourites
        .map((a) => json.encode(_assetToJson(a)))
        .toList();
    await prefs.setStringList('favourites', favJsonList);

    notifyListeners();
  }

  Map<String, dynamic> _assetToJson(AssetModel asset) {
    return {
      "id": asset.id,
      "Title": asset.title,
      "Description": asset.description,
      "thumbnail": asset.thumbnail,
      "publishedAt": asset.publishedAt.toIso8601String(),
      "files": asset.files,
      "previews": asset.previews,
      "is_patreon_locked": asset.isPatreonLocked,
      "categorie": {"Name": asset.categorie},
      "assets_slug": asset.slug,
      "tags": asset.tags,
      "createdAt": asset.createdAt.toIso8601String(),
      "subcategories": asset.subcategories
          .map((s) => {"Name": s.name})
          .toList(),
    };
  }

  /// ✅ Get favorites by subcategory
  List<AssetModel> getFavouritesBySubcategory(String subcategoryName) {
    return _favourites.where((a) {
      return a.subcategories.any(
        (s) => s.name.toLowerCase() == subcategoryName.toLowerCase(),
      );
    }).toList();
  }
}
