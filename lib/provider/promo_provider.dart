// lib/provider/promo_provider.dart
import 'package:cgheven/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:cgheven/model/promo_model.dart';

class PromoProvider extends ChangeNotifier {
  final _apiService = AssetApiService();
  List<PromoModel> promos = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchPromos() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final data = await _apiService.fetchPromos();
      promos = data.where((p) => p.active).toList();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
