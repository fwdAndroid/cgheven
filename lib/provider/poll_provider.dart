import 'package:cgheven/model/polls_model.dart';
import 'package:cgheven/services/api_services.dart';
import 'package:flutter/material.dart';

class PollProvider with ChangeNotifier {
  final AssetApiService _api = AssetApiService();

  List<PollModel> polls = [];
  bool isLoading = false;
  String? error;

  /// Stores which option user selected locally
  Map<int, String> selectedOptions = {};

  Future<void> fetchPolls() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final fetchedPolls = await _api.fetchPolls();
      polls = fetchedPolls;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Dummy local-only vote
  void selectOption(int pollId, String optionKey) {
    selectedOptions[pollId] = optionKey;
    notifyListeners();
  }

  /// Clears selection (optional)
  void clearSelection(int pollId) {
    selectedOptions.remove(pollId);
    notifyListeners();
  }
}
