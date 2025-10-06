import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoProvider with ChangeNotifier {
  final List<VideoPlayerController> _controllers = [];
  int? _currentIndex;

  List<VideoPlayerController> get controllers => _controllers;
  int? get currentIndex => _currentIndex;

  Future<void> initializeVideos(List<String> urls) async {
    disposeAll(); // Clean old

    for (var url in urls) {
      try {
        final decodedUrl = Uri.decodeFull(url);
        // ✅ Accept mp4 and webm files (some previews use webm)
        if (decodedUrl.toLowerCase().endsWith('.mp4') ||
            decodedUrl.toLowerCase().endsWith('.webm')) {
          final controller = VideoPlayerController.networkUrl(
            Uri.parse(decodedUrl),
          );
          await controller.initialize();
          controller.setLooping(true);
          _controllers.add(controller);
        }
      } catch (e) {
        debugPrint("⚠️ Error loading video: $url => $e");
      }
    }

    debugPrint("✅ Loaded ${_controllers.length} videos");
    notifyListeners();
  }

  void playVideo(int index) {
    if (_currentIndex != null && _controllers[_currentIndex!].value.isPlaying) {
      _controllers[_currentIndex!].pause();
    }
    _controllers[index].play();
    _currentIndex = index;
    notifyListeners();
  }

  void pauseVideo(int index) {
    _controllers[index].pause();
    notifyListeners();
  }

  void togglePlayPause(int index) {
    final controller = _controllers[index];
    if (controller.value.isPlaying) {
      pauseVideo(index);
    } else {
      playVideo(index);
    }
  }

  void disposeAll() {
    for (final c in _controllers) {
      c.dispose();
    }
    _controllers.clear();
    _currentIndex = null;
  }

  @override
  void dispose() {
    disposeAll();
    super.dispose();
  }
}
