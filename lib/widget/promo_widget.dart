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
  final Map<int, YoutubePlayerController> _controllers = {};

  @override
  Widget build(BuildContext context) {
    final promoProvider = Provider.of<PromoProvider>(context);

    if (promoProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (promoProvider.promos.isEmpty) {
      return const SizedBox.shrink();
    }

    final promos = promoProvider.promos;

    return SizedBox(
      height: 340,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: promos.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final promo = promos[index];
          final bannerUrl = promo.banners.isNotEmpty ? promo.banners.first : "";
          final videoId = YoutubePlayer.convertUrlToId(bannerUrl);

          // initialize controller only once
          if (videoId != null && !_controllers.containsKey(index)) {
            _controllers[index] = YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
            );
          }

          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 340, // keeps consistent card height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFF00bcd4), width: 1),
              color: AppTheme.darkBackground.withOpacity(0.6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  // 🎬 Image or Video fills top portion
                  if (videoId != null)
                    Positioned.fill(
                      top: 0,
                      bottom: 100, // leave space for title container
                      child: YoutubePlayer(
                        controller: _controllers[index]!,
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
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
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

                  // 🖤 Title + Description (pinned at bottom)
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
                          colors: [
                            Color(0xFF1A1C1D), // top fade (cool dark gray)
                            Color(0xFF16120E), // bottom (warm dark brown-black)
                          ],
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
                                      color: Colors.orangeAccent.withOpacity(
                                        0.7,
                                      ),
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
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
