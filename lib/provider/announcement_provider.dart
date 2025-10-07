import 'package:cgheven/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:cgheven/model/announcement_model.dart';

class AnnouncementProvider with ChangeNotifier {
  final AssetApiService _apiService = AssetApiService();

  List<AnnouncementModel> _announcements = [];
  bool _isLoading = false;

  List<AnnouncementModel> get announcements => _announcements;
  bool get isLoading => _isLoading;

  Future<void> loadAnnouncements() async {
    _isLoading = true;
    notifyListeners();

    try {
      _announcements = await _apiService.fetchAnnouncements();
    } catch (e) {
      debugPrint('Error loading announcements: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
