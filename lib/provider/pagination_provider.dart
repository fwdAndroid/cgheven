import 'package:flutter/material.dart';
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/services/api_services.dart';

class PaginatedAssetProvider with ChangeNotifier {
  final _api = AssetApiService();

  List<AssetModel> _assets = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;

  List<AssetModel> get assets => _assets;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchInitial() async {
    _assets.clear();
    _currentPage = 1;
    _hasMore = true;
    await fetchMore();
  }

  Future<void> fetchMore() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newAssets = await _api.fetchPaginatedAssets(
        page: _currentPage,
        pageSize: 20,
      );

      if (newAssets.isEmpty) {
        _hasMore = false;
      } else {
        _assets.addAll(newAssets);
        _currentPage++;
      }
    } catch (e) {
      debugPrint('❌ Pagination error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
