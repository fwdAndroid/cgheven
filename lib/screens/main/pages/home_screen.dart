import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/provider/announcement_provider.dart';
import 'package:cgheven/provider/api_provider.dart';
import 'package:cgheven/provider/promo_provider.dart';
import 'package:cgheven/screens/detail/assets_detail_page.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:cgheven/widget/search_box_widget.dart';
import 'package:cgheven/widget/shimmer_widget.dart';
import 'package:cgheven/widget/youtube_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeAssetSection = 'New\n Assets';
  String? selectedChip;
  List<AssetModel> _trendingAssets = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AssetProvider>(context, listen: false).getNewAssets();
      Provider.of<PromoProvider>(context, listen: false).fetchPromos();
    });
  }

  /// ✅ Load trending assets from SharedPreferences (most viewed first)
  Future<void> _loadTrendingAssets(AssetProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, int> viewCounts = {};

    // Collect view counts
    for (String key in prefs.getKeys()) {
      if (key.startsWith('asset_views_')) {
        final assetId = key.replaceFirst('asset_views_', '');
        final count = prefs.getInt(key) ?? 0;
        viewCounts[assetId] = count;
      }
    }

    // Filter and sort provider assets based on view counts
    List<AssetModel> trendingAssets = provider.assets.where((asset) {
      return viewCounts.containsKey(asset.id.toString());
    }).toList();

    trendingAssets.sort((a, b) {
      final countA = viewCounts[a.id.toString()] ?? 0;
      final countB = viewCounts[b.id.toString()] ?? 0;
      return countB.compareTo(countA);
    });

    setState(() {
      _trendingAssets = trendingAssets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0B1C24), Color(0xFF1A0F0D)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildSearchAndDownload(),
                  const SizedBox(height: 10),
                  _buildSections(),

                  /// 🔹 News Section via AnnouncementProvider
                  if (activeAssetSection == 'News')
                    Consumer<AnnouncementProvider>(
                      builder: (context, provider, _) {
                        if (provider.isLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(32),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.tealAccent,
                              ),
                            ),
                          );
                        }

                        if (provider.announcements.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "No announcements available.",
                              style: TextStyle(color: Colors.white70),
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 8,
                                bottom: 8,
                              ),
                              child: Text(
                                "📰 Latest Announcements",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ...provider.announcements.map((a) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 6.0,
                                ),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF00bcd4,
                                    ).withOpacity(0.3),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            a.title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            a.content.isNotEmpty
                                                ? a.content
                                                : "No description available",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13,
                                              height: 1.4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      },
                    )
                  /// 🔹 Assets (New / Trending)
                  else
                    Consumer<AssetProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoading && provider.assets.isEmpty) {
                          return buildShimmerGrid();
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

                        final assetsToShow =
                            activeAssetSection == 'Trending\n Assets'
                            ? _trendingAssets
                            : provider.assets;

                        // ✅ Trending Section
                        if (activeAssetSection == 'Trending\n Assets') {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    '🔥 Trending Assets',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (_trendingAssets.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      'No trending assets yet. Watch some assets to make them trend!',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                else
                                  _buildGrid(_trendingAssets),
                              ],
                            ),
                          );
                        }

                        // ✅ Default (New Assets)
                        final Set<String> uniqueSubs = {};
                        for (final asset in provider.assets) {
                          if (asset.categorie.toLowerCase() == 'vfx') {
                            for (final sub in asset.subcategories) {
                              uniqueSubs.add(sub.name);
                            }
                          }
                        }

                        final filteredAssets = selectedChip == null
                            ? <AssetModel>[]
                            : provider.assets.where((asset) {
                                return asset.subcategories.any(
                                  (sub) => sub.name == selectedChip,
                                );
                              }).toList();

                        return Container(
                          decoration: BoxDecoration(
                            color: AppTheme.darkBackground.withOpacity(0.5),

                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF00BCD4).withOpacity(0.3),
                            ),
                          ),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildGrid(assetsToShow),
                              Consumer<PromoProvider>(
                                builder: (context, promoProvider, _) {
                                  if (promoProvider.isLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.tealAccent,
                                      ),
                                    );
                                  }

                                  if (promoProvider.promos.isEmpty)
                                    return const SizedBox.shrink();

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 12),
                                      Text(
                                        "🎬 Current Promos",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 200,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(width: 12),
                                            itemCount:
                                                promoProvider.promos.length,
                                            itemBuilder: (context, index) {
                                              final promo =
                                                  promoProvider.promos[index];
                                              final isYouTube =
                                                  promo.youtubeEmbedUrl !=
                                                      null &&
                                                  promo
                                                      .youtubeEmbedUrl!
                                                      .isNotEmpty;

                                              return Center(
                                                child: Container(
                                                  width: 380,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: AppTheme
                                                        .darkBackground
                                                        .withOpacity(0.5),

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                    border: Border.all(
                                                      color: const Color(
                                                        0xFF00BCD4,
                                                      ).withOpacity(0.3),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        blurRadius: 4,
                                                        offset: const Offset(
                                                          0,
                                                          3,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: isYouTube
                                                              ? YoutubePlayerWidget(
                                                                  embedUrl: promo
                                                                      .youtubeEmbedUrl!,
                                                                )
                                                              : Image.network(
                                                                  promo
                                                                      .bannerUrl,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: double
                                                                      .infinity,
                                                                ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                8.0,
                                                              ),
                                                          child: Text(
                                                            promo.title,
                                                            style:
                                                                const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 8.0,
                                                              ),
                                                          child: Text(
                                                            promo.description,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                                  color: Colors
                                                                      .white70,
                                                                  fontSize: 12,
                                                                ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              if (uniqueSubs.isNotEmpty) ...[
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: uniqueSubs.map((sub) {
                                    final isSelected = selectedChip == sub;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedChip = isSelected
                                              ? null
                                              : sub;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
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
                                              : const Color(
                                                  0xFF374151,
                                                ).withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                          border: Border.all(
                                            color: const Color(
                                              0xFF00bcd4,
                                            ).withOpacity(.4),
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
                                const SizedBox(height: 20),
                                if (selectedChip != null) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      'Showing results for "$selectedChip"',
                                      style: GoogleFonts.inter(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  _buildGrid(filteredAssets),
                                ],
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Search bar + download icon
  Widget _buildSearchAndDownload() {
    return Row(
      children: [
        Expanded(child: buildSearchBox(context)),
        IconButton(
          icon: const Icon(Icons.download, color: Color(0xFF9CA3AF), size: 32),
          onPressed: () {},
        ),
      ],
    );
  }

  /// 🔹 Tabs (New, Trending, News)
  Widget _buildSections() {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppTheme.darkBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00bcd4).withOpacity(.3)),
      ),
      child: Row(
        children: ['New\n Assets', 'Trending\n Assets', 'News'].map((section) {
          final isActive = activeAssetSection == section;
          return Expanded(
            child: GestureDetector(
              onTap: () async {
                setState(() => activeAssetSection = section);
                final assetProvider = Provider.of<AssetProvider>(
                  context,
                  listen: false,
                );
                final announcementProvider = Provider.of<AnnouncementProvider>(
                  context,
                  listen: false,
                );

                if (section == 'New\n Assets') {
                  assetProvider.getNewAssets();
                } else if (section == 'Trending\n Assets') {
                  await _loadTrendingAssets(assetProvider);
                } else if (section == 'News') {
                  announcementProvider.loadAnnouncements();
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
    );
  }

  /// 🔹 Grid layout for displaying assets
  Widget _buildGrid(List<AssetModel> assets) {
    final screenWidth = MediaQuery.of(context).size.width;
    const crossAxisCount = 2;
    const spacing = 16.0;
    final totalSpacing = spacing * (crossAxisCount + 1);
    final cardWidth = (screenWidth - totalSpacing - 24) / crossAxisCount;
    final cardHeight = cardWidth * 0.9;
    final aspectRatio = cardWidth / cardHeight;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 12, bottom: 12),
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
}
