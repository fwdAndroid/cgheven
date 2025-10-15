import 'package:cgheven/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AssetPreviewPlayer extends StatefulWidget {
  final String videoUrl;
  // final String? green_screen;

  const AssetPreviewPlayer({
    super.key,
    required this.videoUrl,
    // this.green_screen,
  });

  @override
  State<AssetPreviewPlayer> createState() => _AssetPreviewPlayerState();
}

class _AssetPreviewPlayerState extends State<AssetPreviewPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showGreenScreen = false;

  @override
  void initState() {
    super.initState();
    _initializeController(widget.videoUrl);
  }

  void _initializeController(String url) {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(() {
        if (mounted) setState(() {});
      });
  }

  // void _toggleVideoSource() {
  //   if (widget.green_screen != null && widget.green_screen!.isNotEmpty) {
  //     setState(() {
  //       _showGreenScreen = !_showGreenScreen;
  //       _controller.pause();
  //       _controller.dispose();
  //       _initializeController(
  //         _showGreenScreen ? widget.green_screen! : widget.videoUrl,
  //       );
  //     });
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    final isReady = _controller.value.isInitialized;
    final duration = _controller.value.duration;
    final position = _controller.value.position;
    final buffered = _controller.value.buffered.isNotEmpty
        ? _controller.value.buffered.last.end
        : Duration.zero;

    final progress = isReady && duration.inMilliseconds > 0
        ? position.inMilliseconds / duration.inMilliseconds
        : 0.0;

    final bufferedProgress = isReady && duration.inMilliseconds > 0
        ? buffered.inMilliseconds / duration.inMilliseconds
        : 0.0;

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.darkBackground.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF00bcd4), width: 0.3),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: isReady ? _controller.value.aspectRatio : 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: isReady
                    ? VideoPlayer(_controller)
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.white24),
                      ),
              ),
            ),

            // ▶️ Play/Pause button
            GestureDetector(
              onTap: () async {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  await _controller.play();
                }
                setState(() => _isPlaying = _controller.value.isPlaying);
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),

            // ⏳ Progress bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          FractionallySizedBox(
                            widthFactor: bufferedProgress,
                            child: Container(height: 4, color: Colors.white24),
                          ),
                          FractionallySizedBox(
                            widthFactor: progress,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.teal, Colors.orange],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${_formatDuration(position)} / ${_formatDuration(duration)}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),

            // 🟩 Toggle button (only if green_screen exists)
            // if (widget.green_screen != null && widget.green_screen!.isNotEmpty)
            //   Positioned(
            //     top: 8,
            //     right: 8,
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.teal,
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 10,
            //           vertical: 6,
            //         ),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //       ),
            //       onPressed: _toggleVideoSource,
            //       child: Text(
            //         _showGreenScreen ? 'Normal Preview' : 'Green Screen',
            //         style: const TextStyle(fontSize: 12, color: Colors.white),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
