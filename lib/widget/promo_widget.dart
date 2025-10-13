import 'package:cgheven/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cgheven/provider/promo_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PromoWidget extends StatefulWidget {
  const PromoWidget({Key? key}) : super(key: key);

  @override
  State<PromoWidget> createState() => _PromoWidgetState();
}

class _PromoWidgetState extends State<PromoWidget> {
  YoutubePlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    final promoProvider = Provider.of<PromoProvider>(context);

    if (promoProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (promoProvider.promos.isEmpty) {
      return const Center(child: Text("No promos available"));
    }

    final promo = promoProvider.promos.first; // only first promo
    final videoUrl = promo.banner.toString();
    "";
    final videoId = YoutubePlayer.convertUrlToId(videoUrl ?? '');

    if (videoId != null && _controller == null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.darkBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00bcd4).withOpacity(.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          if (_controller != null)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: YoutubePlayer(
                controller: _controller!,
                showVideoProgressIndicator: true,
              ),
            ),
          const SizedBox(height: 10),
          Text(
            promo.title ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            promo.description.toString(),
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
