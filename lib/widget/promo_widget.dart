import 'dart:ui';
import 'package:cgheven/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      return const SizedBox.shrink();
    }

    // show only the first promo
    final promo = promoProvider.promos.first;
    final bannerUrl = promo.banners.isNotEmpty ? promo.banners.first : "";
    final videoId = YoutubePlayer.convertUrlToId(bannerUrl);

    // initialize controller if video exists
    if (videoId != null && _controller == null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth * 0.9;

    return Center(
      child: Container(
        width: itemWidth,
        height: 340,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFF00bcd4), width: 1),
          color: AppTheme.darkBackground.withOpacity(0.6),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              // 🎬 Image or Video section
              if (videoId != null)
                Positioned.fill(
                  top: 0,
                  bottom: 100,
                  child: YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.cyanAccent,
                  ),
                )
              else if (bannerUrl.isNotEmpty)
                Positioned.fill(
                  top: 0,
                  bottom: 100,
                  child: Image.network(
                    bannerUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.black26,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                        size: 40,
                      ),
                    ),
                  ),
                ),

              // 🖤 Bottom title and description
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 22,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF1A1C1D), Color(0xFF16120E)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              promo.title,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orangeAccent.withOpacity(0.7),
                                  blurRadius: 2,
                                  spreadRadius: .9,
                                ),
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.4),
                                  blurRadius: .9,
                                  spreadRadius: 1,
                                ),
                              ],
                              gradient: AppTheme.fireGradient,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'NEW',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        promo.description.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
