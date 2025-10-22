import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/services/api_services.dart';
import 'package:flutter/material.dart';

class AssetProvider with ChangeNotifier {
  List<AssetModel> _assets = [];
  bool _isLoading = false;
  String? _error;

  // New: mark loaded state for caching
  bool _isLoaded = false;

  List<AssetModel> get assets => _assets;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoaded => _isLoaded;

  final _apiService = AssetApiService();

  List<AssetModel> _assetsBySubcategory = [];
  List<AssetModel> get assetsBySubcategory => _assetsBySubcategory;

  List<AssetModel> _latestEditedAssets = [];
  bool _isLoadingLatest = false;
  bool _isLatestLoaded = false;

  List<AssetModel> get latestEditedAssets => _latestEditedAssets;
  bool get isLoadingLatest => _isLoadingLatest;

  // New: force refresh
  Future<void> refreshAll() async {
    _isLoaded = false;
    _isLatestLoaded = false;
    await Future.wait([
      getNewAssets(force: true),
      getLatestEditedAssets(force: true),
    ]);
  }

  Future<void> getLatestEditedAssets({
    int limit = 10,
    bool force = false,
  }) async {
    if (_isLatestLoaded && !force) return;
    _isLoadingLatest = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _apiService.fetchLatestEditedAssets(limit: limit);
      _latestEditedAssets = result;
      _isLatestLoaded = true;
      debugPrint('✅ Loaded ${_latestEditedAssets.length} latest edited assets');
    } catch (e) {
      _error = e.toString();
      debugPrint('❌ Error loading latest edited assets: $_error');
    }

    _isLoadingLatest = false;
    notifyListeners();
  }

  Future<void> getNewAssets({bool force = false}) async {
    if (_isLoaded && !force) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await AssetApiService().fetchNewAssets();

      _assets = result
          .where((asset) => asset.categorie.toLowerCase() == 'vfx')
          .toList();

      _isLoaded = true;
      debugPrint('✅ Loaded ${_assets.length} VFX assets');
    } catch (e) {
      _error = e.toString();
      debugPrint('❌ Error loading VFX assets: $_error');
    }

    _isLoading = false;
    notifyListeners();
  }

  // keep setAssets, filterByCategory, getAssetsBySubcategory but add guard if wanted
  Future<void> getAssetsBySubcategory(
    String subcategoryName, {
    bool force = false,
  }) async {
    if (_assetsBySubcategory.isNotEmpty && !force && subcategoryName == '')
      return;
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
