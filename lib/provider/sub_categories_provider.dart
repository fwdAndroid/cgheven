import 'package:flutter/material.dart';
import 'package:cgheven/model/assets_model.dart';
import 'package:cgheven/services/api_service.dart';

class SubCategoryProvider with ChangeNotifier {
  List<String> _subCategories = [];
  bool _isLoading = false;
  String? _error;
  String? _activeSubCategory;

  List<String> get subCategories => _subCategories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get activeSubCategory => _activeSubCategory;

  Future<void> fetchSubCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final assets = await AssetService.fetchAssets();

      // ✅ only VFX assets
      final vfxAssets = assets.where((a) => a.category == "VFX").toList();

      // ✅ unique subcategories
      _subCategories = vfxAssets
          .expand((a) => a.subCategories)
          .toSet()
          .toList();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void setActiveSubCategory(String? subCat) {
    _activeSubCategory = subCat;
    notifyListeners();
  }
}
