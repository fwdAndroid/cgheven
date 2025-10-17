import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/services/api_services.dart';
import 'package:flutter/material.dart';

class AssetProvider with ChangeNotifier {
  List<AssetModel> _assets = [];
  bool _isLoading = false;
  String? _error;

  List<AssetModel> get assets => _assets;
  bool get isLoading => _isLoading;
  String? get error => _error;
  final _apiService = AssetApiService();
  // ✅ Only fetch VFX assets
  Future<void> getNewAssets() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await AssetApiService().fetchNewAssets();

      // ✅ Filter by lowercase 'vfx'
      _assets = result
          .where((asset) => asset.categorie.toLowerCase() == 'vfx')
          .toList();

      debugPrint('✅ Loaded ${_assets.length} VFX assets');
    } catch (e) {
      _error = e.toString();
      debugPrint('❌ Error loading VFX assets: $_error');
    }

    _isLoading = false;
    notifyListeners();
  }

  // ✅ Update assets manually
  void setAssets(List<AssetModel> newAssets) {
    _assets = newAssets;
    notifyListeners();
  }

  // ✅ Filter by Subcategory (or reset)
  Future<void> filterByCategory(String? categoryName) async {
    if (categoryName == null) {
      await getNewAssets(); // reset to all VFX assets
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiService.fetchAssetsByCategory(categoryName);
      _assets = result;
      debugPrint("✅ Filtered ${_assets.length} assets for '$categoryName'");
    } catch (e) {
      _error = e.toString();
      debugPrint("❌ Error filtering by category: $_error");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAssetsBySubcategory(String subcategoryName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await AssetApiService().fetchAssetsBySubcategory(
        subcategoryName,
      );
      _assets = result;
      print('✅ Loaded ${_assets.length} assets for $subcategoryName');
    } catch (e) {
      _error = e.toString();
      print('❌ Error loading assets by subcategory: $_error');
    }

    _isLoading = false;
    notifyListeners();
  }
}
