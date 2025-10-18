import 'package:cgheven/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:cgheven/model/promo_model.dart';

class PromoProvider with ChangeNotifier {
  final AssetApiService _apiService = AssetApiService();
  List<Promo> _promos = [];
  bool _isLoading = false;

  List<Promo> get promos => _promos;
  bool get isLoading => _isLoading;

  Future<void> fetchPromos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _promos = await _apiService.fetchPromos();
      print("Promo titles: ${_promos.map((p) => p.title).toList()}");
    } catch (e) {
      print("Error fetching promos: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
