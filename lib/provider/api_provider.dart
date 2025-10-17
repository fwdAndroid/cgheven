import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/services/api_services.dart';
import 'package:flutter/material.dart';

class AssetProvider with ChangeNotifier {
  // ---------- Existing fields ----------
  List<AssetModel> _assets = [];
  bool _isLoading = false;
  String? _error;

  List<AssetModel> get assets => _assets;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final _apiService = AssetApiService();

  List<AssetModel> _assetsBySubcategory = [];
  List<AssetModel> get assetsBySubcategory => _assetsBySubcategory;

  // ---------- New: Latest Edited Assets ----------
  List<AssetModel> _latestEditedAssets = [];
  bool _isLoadingLatest = false;

  List<AssetModel> get latestEditedAssets => _latestEditedAssets;
  bool get isLoadingLatest => _isLoadingLatest;

  // ---------- Fetch Latest Edited Assets ----------
  Future<void> getLatestEditedAssets({int limit = 10}) async {
    _isLoadingLatest = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _apiService.fetchLatestEditedAssets(limit: limit);
      _latestEditedAssets = result;
      debugPrint('✅ Loaded ${_latestEditedAssets.length} latest edited assets');
    } catch (e) {
      _error = e.toString();
      debugPrint('❌ Error loading latest edited assets: $_error');
    }

    _isLoadingLatest = false;
    notifyListeners();
  }

  // ---------- Existing: Fetch New Assets ----------
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

  // ---------- Update assets manually ----------
  void setAssets(List<AssetModel> newAssets) {
    _assets = newAssets;
    notifyListeners();
  }

  // ---------- Filter by Category ----------
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

  // ---------- Filter by Subcategory ----------
  Future<void> getAssetsBySubcategory(String subcategoryName) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _apiService.fetchAssetsBySubcategory(
        subcategoryName,
      );
      _assetsBySubcategory = result;
      debugPrint(
        '✅ Loaded ${_assetsBySubcategory.length} assets for $subcategoryName',
      );
    } catch (e) {
      _error = e.toString();
      debugPrint('❌ Error loading assets by subcategory: $_error');
    }

    _isLoading = false;
    notifyListeners();
  }
}
