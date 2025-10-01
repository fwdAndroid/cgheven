import 'package:cgheven/model/category.dart';
import 'package:cgheven/services/api_service.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await AssetService.fetchCategories();

      // ✅ remove duplicates by name
      final unique = <String, Category>{};
      for (var c in result) {
        unique[c.name] = c; // overwrites duplicates
      }

      _categories = unique.values.toList();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
