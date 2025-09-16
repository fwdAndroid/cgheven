import 'package:cgheven/screens/utils/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureCard extends StatelessWidget {
  final Map<String, dynamic> feature;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final int currentIndex;
  final int totalCount;

  const FeatureCard({
    super.key,
    required this.feature,
    required this.onPrevious,
    required this.onNext,
    required this.currentIndex,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.darkBackground.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.tealStart.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Feature Image
          Container(
            width: 160,
            height: 160,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.fireStart.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: AppTheme.fireGlowShadow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: feature['image'],
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppTheme.darkSecondary,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.tealStart,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppTheme.darkSecondary,
                      child: const Icon(Icons.error, color: AppTheme.fireStart),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        feature['icon'],
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Feature Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  feature['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  feature['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppTheme.textSecondary.withOpacity(0.8),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous Button
                IconButton(
                  onPressed: onPrevious,
                  icon: const Icon(Icons.chevron_left),
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.darkBackground.withOpacity(0.5),
                    foregroundColor: AppTheme.textPrimary,
                    side: BorderSide(
                      color: AppTheme.tealStart.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),

                // Slide Indicators
                Row(
                  children: List.generate(totalCount, (index) {
                    return Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        gradient: index == currentIndex
                            ? AppTheme.logoGradient
                            : null,
                        color: index == currentIndex
                            ? null
                            : AppTheme.textSecondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: index == currentIndex
                            ? AppTheme.fireGlowShadow
                            : null,
                      ),
                    );
                  }),
                ),

                // Next Button
                IconButton(
                  onPressed: onNext,
                  icon: const Icon(Icons.chevron_right),
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.darkBackground.withOpacity(0.5),
                    foregroundColor: AppTheme.textPrimary,
                    side: BorderSide(
                      color: AppTheme.tealStart.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
