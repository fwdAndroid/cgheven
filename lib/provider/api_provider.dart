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

  Future<void> getNewAssets() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await AssetApiService().fetchNewAssets();

      // ✅ Filter: keep assets whose category name is "VFX"
      _assets = result
          .where((asset) => asset.categorie.toLowerCase() == 'vfx')
          .toList();

      debugPrint('✅ Loaded ${_assets.length} VFX assets');
    } catch (e) {
      _error = e.toString();
      debugPrint('❌ Error loading assets: $_error');
    }

    _isLoading = false;
    notifyListeners();
  }
}
