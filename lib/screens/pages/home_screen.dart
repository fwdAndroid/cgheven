import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/screens/detail/asset_detail_screen.dart';
import 'package:cgheven/screens/pages/community_screen.dart';
import 'package:cgheven/screens/pages/download_screen.dart';
import 'package:cgheven/screens/search_screen/search_screen.dart';
import 'package:cgheven/widget/animated_background.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:cgheven/widget/news_card_widget.dart';
import 'package:flutter/material.dart';

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
      body: AnimatedBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => CommunityPage(),
                                ),
                              );
                            },
                            icon: Icon(Icons.group, color: Color(0xff25b09f)),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1F2937).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFF374151),
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
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText:
                                      'Search effects, explosions, magic...',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF9CA3AF),
                                  ),
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

                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => DownloadScreen(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.download,
                              color: Color(0xff25b09f),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Asset Section Buttons
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2937).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF374151),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ['New Assets', 'Trending Assets', 'News']
                              .map((section) {
                                final isActive = activeAssetSection == section;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      activeAssetSection = section;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal:
                                          16, // add some horizontal padding
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ), // <-- spacing
                                    decoration: BoxDecoration(
                                      gradient: isActive
                                          ? const LinearGradient(
                                              colors: [
                                                Color(0xFF14B8A6),
                                                Color(0xFFF97316),
                                              ],
                                            )
                                          : null,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      section,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.white
                                            : const Color(0xFF9CA3AF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Asset Grid for Selected Section
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
                        GridView.builder(
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
                                    builder: (context) =>
                                        const AssetDetailScreen(),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      const SizedBox(height: 24),

                      // Featured Card
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2937).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFF374151),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 192,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                    child: Image.network(
                                      'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=800',
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.8),
                                        ],
                                      ),
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(24),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Gas Explosion Pack – New Drop',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Professional VFX assets ready for production',
                                          style: TextStyle(
                                            color: Color(0xFF9CA3AF),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF14B8A6),
                                          Color(0xFFF97316),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Text(
                                      'NEW',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Category Filter Chips
                      SizedBox(
                        height: 48,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final isActive = activeCategory == category;
                            return Container(
                              margin: const EdgeInsets.only(right: 12),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    activeCategory = category;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: isActive
                                        ? const LinearGradient(
                                            colors: [
                                              Color(0xFF14B8A6),
                                              Color(0xFFF97316),
                                            ],
                                          )
                                        : null,
                                    color: isActive
                                        ? null
                                        : const Color(
                                            0xFF374151,
                                          ).withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: isActive
                                          ? Colors.transparent
                                          : const Color(0xFF374151),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      color: isActive
                                          ? Colors.white
                                          : const Color(0xFF9CA3AF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Main Asset Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: assets.length,
                        itemBuilder: (context, index) {
                          final asset = assets[index];
                          return AssetCard(
                            asset: asset,
                            showBadge: false,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AssetDetailScreen(),
                                ),
                              );
                            },
                          );
                        },
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
}
