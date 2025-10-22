import 'package:cgheven/model/announcement_model.dart';
import 'package:cgheven/services/api_services.dart';
import 'package:flutter/material.dart';

class AnnouncementProvider with ChangeNotifier {
  final AssetApiService _apiService = AssetApiService();

  List<AnnouncementModel> _announcements = [];
  bool _isLoading = false;
  bool _isLoaded = false;

  List<AnnouncementModel> get announcements => _announcements;
  bool get isLoading => _isLoading;
  bool get isLoaded => _isLoaded;

  Future<void> loadAnnouncements({bool force = false}) async {
    if (_isLoaded && !force) return;
    _isLoading = true;
    notifyListeners();

    try {
      _announcements = await _apiService.fetchAnnouncements();
      _isLoaded = true;
      debugPrint('✅ Loaded ${_announcements.length} announcements');
    } catch (e) {
      debugPrint('Error loading announcements: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
