import 'dart:ui';

import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/screens/detail/asset_detail_screen.dart';
import 'package:cgheven/screens/search_screen/search_screen.dart';
import 'package:cgheven/screens/utils/apptheme.dart';
import 'package:cgheven/screens/utils/gradient_button.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:cgheven/widget/news_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeCategory = 'All';
  int activeNavIndex = 0;
  String activeAssetSection = 'New Assets';

  final List<String> categories = [
    'All',
    'Explosion',
    'Fire',
    'Smoke',
    'Lightning',
    'Magic',
    'Dust',
    'Debris',
  ];

  final List<Asset> newAssets = [
    Asset(
      id: 7,
      title: 'Plasma Energy Burst',
      thumbnail:
          'https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Energy',
      isNew: true,
    ),
    Asset(
      id: 8,
      title: 'Volcanic Eruption',
      thumbnail:
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Fire',
      isNew: true,
    ),
    Asset(
      id: 9,
      title: 'Electric Storm',
      thumbnail:
          'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Lightning',
      isNew: true,
    ),
    Asset(
      id: 10,
      title: 'Mystic Portal',
      thumbnail:
          'https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Magic',
      isNew: true,
    ),
  ];

  final List<Asset> trendingAssets = [
    Asset(
      id: 11,
      title: 'Nuclear Blast Wave',
      thumbnail:
          'https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Explosion',
      downloads: '8.2K',
    ),
    Asset(
      id: 12,
      title: 'Dragon Fire Breath',
      thumbnail:
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Fire',
      downloads: '6.7K',
    ),
    Asset(
      id: 13,
      title: 'Thunder Lightning',
      thumbnail:
          'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Lightning',
      downloads: '5.9K',
    ),
    Asset(
      id: 14,
      title: 'Toxic Smoke Cloud',
      thumbnail:
          'https://images.pexels.com/photos/590016/pexels-photo-590016.jpg?auto=compress&cs=tinysrgb&w=400',
      category: 'Smoke',
      downloads: '4.8K',
    ),
  ];

  final List<NewsItem> newsItems = [
    NewsItem(
      id: 1,
      title: 'Fire Pack V3.0 Released',
      thumbnail:
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400',
      date: '2 days ago',
      description: 'Enhanced fire simulations with improved alpha channels',
    ),
    NewsItem(
      id: 2,
      title: 'Lightning Collection Update',
      thumbnail:
          'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400',
      date: '1 week ago',
      description: 'Added 12 new lightning strike variations',
    ),
    NewsItem(
      id: 3,
      title: 'ProRes 444 Format Available',
      thumbnail:
          'https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=400',
      date: '2 weeks ago',
      description: 'All assets now support ProRes 444 format',
    ),
    NewsItem(
      id: 4,
      title: 'Community Challenge Winner',
      thumbnail:
          'https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&w=400',
      date: '3 weeks ago',
      description: 'Best explosion composition contest results',
    ),
  ];

  final List<Asset> assets = [
    Asset(
      id: 1,
      title: 'Epic Fire Blast',
      thumbnail:
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Fire',
    ),
    Asset(
      id: 2,
      title: 'Lightning Strike',
      thumbnail:
          'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Lightning',
    ),
    Asset(
      id: 3,
      title: 'Smoke Plume',
      thumbnail:
          'https://images.pexels.com/photos/590016/pexels-photo-590016.jpg?auto=compress&cs=tinysrgb&w=400',
      category: 'Smoke',
    ),
    Asset(
      id: 4,
      title: 'Magic Sparkles',
      thumbnail:
          'https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Magic',
    ),
    Asset(
      id: 5,
      title: 'Dust Cloud',
      thumbnail:
          'https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Dust',
    ),
    Asset(
      id: 6,
      title: 'Debris Scatter',
      thumbnail:
          'https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=400',
      category: 'Debris',
    ),
  ];

  List<dynamic> getCurrentAssets() {
    switch (activeAssetSection) {
      case 'New Assets':
        return newAssets;
      case 'Trending Assets':
        return trendingAssets;
      case 'News':
        return newsItems;
      default:
        return newAssets;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // 135 degrees = top-left → bottom-right
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0B1C24), // #0b1c24 at 0%
              Color(0xFF1A0F0D), // #1a0f0d at 100%
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0d0c0b),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF00bcd4).withOpacity(.4),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                    },
                    style: GoogleFonts.poppins(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search effects, explosions, magic...',
                      hintStyle: GoogleFonts.poppins(color: Color(0xFF9CA3AF)),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF9CA3AF),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0d0c0b),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF00bcd4).withOpacity(.4),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['News\nAssets', 'Trending\nAssets', 'News'].map((
                      section,
                    ) {
                      final isActive = activeAssetSection == section;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: GradientButton(
                          gradient: isActive
                              ? AppTheme.fireGradient
                              : LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                ),
                          onPressed: () {
                            setState(() {
                              activeAssetSection = section;
                            });
                          },
                          child: SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                section,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: isActive
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isActive
                                      ? Colors.white
                                      : const Color(0xFFB0B0B0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (activeAssetSection == 'News')
                Column(
                  children: getCurrentAssets()
                      .cast<NewsItem>()
                      .map(
                        (item) => NewsCard(
                          newsItem: item,
                          onTap: () {
                            // Handle news item tap
                          },
                        ),
                      )
                      .toList(),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 2.0,
                  ), // almost flush
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                    itemCount: getCurrentAssets().length,
                    itemBuilder: (context, index) {
                      final asset = getCurrentAssets()[index] as Asset;
                      return AssetCard(
                        asset: asset,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssetDetailScreen(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
