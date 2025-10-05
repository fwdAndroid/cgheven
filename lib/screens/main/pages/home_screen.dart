import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/provider/api_provider.dart';
import 'package:cgheven/screens/detail/assets_detail_page.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeAssetSection = 'New\n Assets';
  String? selectedChip; // ✅ Track selected chip

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AssetProvider>(context, listen: false).getNewAssets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0B1C24), Color(0xFF1A0F0D)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildSearchAndDownload(),
                _buildSections(),
                Consumer<AssetProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading && provider.assets.isEmpty) {
                      return _buildShimmerGrid();
                    }

                    if (provider.error != null) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Error: ${provider.error}',
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      );
                    }

                    if (provider.assets.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'No assets found.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }

                    // ✅ Get unique subcategories for category == VFX
                    final Set<String> uniqueSubs = {};
                    for (final asset in provider.assets) {
                      if (asset.categorie.toLowerCase() == 'vfx') {
                        for (final sub in asset.subcategories) {
                          uniqueSubs.add(sub.name);
                        }
                      }
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGrid(provider.assets),

                        if (uniqueSubs.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: uniqueSubs.map((sub) {
                                final isSelected = selectedChip == sub;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedChip = isSelected
                                          ? null
                                          : sub; // toggle
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          isSelected
                                              ? 'Unselected $sub'
                                              : 'Selected $sub',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        duration: const Duration(
                                          milliseconds: 800,
                                        ),
                                      ),
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: isSelected
                                          ? AppTheme.fireGradient
                                          : null,
                                      color: isSelected
                                          ? null
                                          : AppTheme.darkBackground.withOpacity(
                                              0.6,
                                            ),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color(0xFF00bcd4),
                                        width: 0.6,
                                      ),
                                    ),
                                    child: Text(
                                      sub,
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndDownload() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      child: Row(
        children: [
          Expanded(child: _buildSearchBox(context)),
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Color(0xFF9CA3AF),
              size: 32,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSections() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          children: ['New\n Assets', 'Trending\n Assets', 'News'].map((
            section,
          ) {
            final isActive = activeAssetSection == section;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => activeAssetSection = section);
                  final assetProvider = Provider.of<AssetProvider>(
                    context,
                    listen: false,
                  );

                  if (section == 'New\n Assets') {
                    assetProvider.getNewAssets();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: isActive ? AppTheme.fireGradient : null,
                    color: isActive ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      section,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.white10,
          highlightColor: Colors.white24,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF00bcd4).withOpacity(.2),
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<AssetModel> assets) {
    final screenWidth = MediaQuery.of(context).size.width;
    const crossAxisCount = 2;
    const spacing = 16.0;
    final totalSpacing = spacing * (crossAxisCount + 1);
    final cardWidth = (screenWidth - totalSpacing) / crossAxisCount;
    final cardHeight = cardWidth * 0.9;
    final aspectRatio = cardWidth / cardHeight;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: assets.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (context, index) {
        final asset = assets[index];
        return AssetCard(
          asset: asset,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => AssetDetailScreen(asset: asset),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSearchBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkBackground.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00bcd4).withOpacity(.4),
          width: 1,
        ),
      ),
      child: TextField(
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search effects, explosions, magic...',
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xFF9CA3AF),
            fontSize: 14,
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
