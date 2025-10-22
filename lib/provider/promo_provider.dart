import 'package:cgheven/model/promo_model.dart';
import 'package:cgheven/services/api_services.dart';
import 'package:flutter/material.dart';

class PromoProvider with ChangeNotifier {
  final AssetApiService _apiService = AssetApiService();
  List<Promo> _promos = [];
  bool _isLoading = false;
  bool _isLoaded = false;

  List<Promo> get promos => _promos;
  bool get isLoading => _isLoading;
  bool get isLoaded => _isLoaded;

  Future<void> fetchPromos({bool force = false}) async {
    if (_isLoaded && !force) return;
    _isLoading = true;
    notifyListeners();

    try {
      _promos = await _apiService.fetchPromos();
      _isLoaded = true;
      debugPrint('✅ Loaded ${_promos.length} promos');
    } catch (e) {
      debugPrint("Error fetching promos: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
