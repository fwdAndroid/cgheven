import 'package:cgheven/model/assets_model.dart';
import 'package:cgheven/services/api_service.dart';
import 'package:flutter/material.dart';

class AssetProvider with ChangeNotifier {
  List<Asset> _assets = [];
  bool _isLoading = false;
  String? _error;

  List<Asset> get assets => _assets;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAssets() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await AssetService.fetchAssets();
      _assets = result;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
