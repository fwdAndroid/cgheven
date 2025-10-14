import 'package:flutter/material.dart';
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/services/api_services.dart';

class SearchProvider with ChangeNotifier {
  List<AssetModel> _results = [];
  bool _isLoading = false;
  String? _error;

  List<AssetModel> get results => _results;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> search(String query) async {
    if (query.trim().isEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _results = await AssetApiService().searchAssets(query);
      print('🔍 Found ${_results.length} results for "$query"');
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _results = [];
    _error = null;
    notifyListeners();
  }
}
