import 'package:cgheven/provider/api_provider.dart';
import 'package:cgheven/provider/category_provider.dart';
import 'package:cgheven/screens/detail/asset_detail_screen.dart';
import 'package:cgheven/screens/pages/download_screen.dart';
import 'package:cgheven/screens/search_screen/search_screen.dart';
import 'package:cgheven/screens/utils/apptheme.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeAssetSection = 'New\n Assets'; // default active tab
  String? activeCategory; // ✅ add this line

  @override
  void initState() {
    super.initState();
    // Fetch assets when HomeScreen is created
    Future.microtask(() {
      Provider.of<AssetProvider>(context, listen: false).fetchAssets();
      Provider.of<CategoryProvider>(
        context,
        listen: false,
      ).fetchCategories(); // ✅ fetch categories
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.darkBackground.withOpacity(0.6),
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
                              hintStyle: GoogleFonts.poppins(
                                color: Color(0xFF9CA3AF),
                                fontSize: 14,
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
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.download,
                        color: Color(0xFF9CA3AF),
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DownloadScreen(),
                          ),
                        );
                        // Handle notification icon tap
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppTheme.darkBackground.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF00bcd4).withOpacity(.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: ['New\n Assets', 'Trending\n Assets', 'News'].map(
                      (section) {
                        final isActive = activeAssetSection == section;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                activeAssetSection = section;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.all(
                                6,
                              ), // spacing from edges
                              decoration: BoxDecoration(
                                gradient: isActive
                                    ? AppTheme.fireGradient
                                    : null,
                                color: isActive ? null : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  section,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: isActive
                                        ? FontWeight.w700
                                        : FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),

              /// 🔹 Assets Grid
              Consumer<AssetProvider>(
                builder: (context, assetProvider, child) {
                  if (assetProvider.isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(color: Colors.cyan),
                    );
                  }

                  if (assetProvider.error != null) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Error: ${assetProvider.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (assetProvider.assets.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "No assets found",
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  final screenWidth = MediaQuery.of(context).size.width;
                  const crossAxisCount = 2;
                  const spacing = 16.0;
                  final totalSpacing = spacing * (crossAxisCount + 1);
                  final cardWidth =
                      (screenWidth - totalSpacing) / crossAxisCount;
                  final cardHeight = cardWidth * 0.9;
                  final aspectRatio = cardWidth / cardHeight;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: assetProvider.assets.length,
                    itemBuilder: (context, index) {
                      final asset = assetProvider.assets[index];
                      return AssetCard(
                        asset: asset,
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         AssetDetailScreen(asset: asset),
                          //   ),
                          // );
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 24),

              // Category Filter Chips
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, child) {
                    if (categoryProvider.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(color: Colors.cyan),
                      );
                    }

                    if (categoryProvider.error != null) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Error: ${categoryProvider.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (categoryProvider.categories.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "No categories found",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,

                        child: Wrap(
                          alignment:
                              WrapAlignment.start, // ✅ chips start from left

                          spacing: 12,
                          runSpacing: 12,
                          children: categoryProvider.categories.map((category) {
                            final isActive = activeCategory == category.name;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  activeCategory = category.name;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isActive
                                      ? AppTheme.fireGradient
                                      : null,
                                  color: isActive
                                      ? null
                                      : const Color(
                                          0xFF374151,
                                        ).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF00bcd4,
                                    ).withOpacity(.4),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  category.name,
                                  style: GoogleFonts.poppins(
                                    color: isActive
                                        ? Colors.white
                                        : const Color(0xFF9CA3AF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// 🔹 Assets Grid
              Consumer<AssetProvider>(
                builder: (context, assetProvider, child) {
                  if (assetProvider.isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(color: Colors.cyan),
                    );
                  }

                  if (assetProvider.error != null) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Error: ${assetProvider.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (assetProvider.assets.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "No assets found",
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  // ✅ Filter assets according to selected category
                  final filteredAssets = activeCategory == null
                      ? assetProvider.assets
                      : assetProvider.assets
                            .where((asset) => asset.category == activeCategory)
                            .toList();

                  final screenWidth = MediaQuery.of(context).size.width;
                  const crossAxisCount = 2;
                  const spacing = 16.0;
                  final totalSpacing = spacing * (crossAxisCount + 1);
                  final cardWidth =
                      (screenWidth - totalSpacing) / crossAxisCount;
                  final cardHeight = cardWidth * 0.9;
                  final aspectRatio = cardWidth / cardHeight;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: filteredAssets.length,
                    itemBuilder: (context, index) {
                      final asset = filteredAssets[index];
                      return AssetCard(
                        asset: asset,
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         AssetDetailScreen(asset: asset),
                          //   ),
                          // );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
