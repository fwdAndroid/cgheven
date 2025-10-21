import 'dart:ui';

import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/provider/announcement_provider.dart';
import 'package:cgheven/provider/api_provider.dart';
import 'package:cgheven/provider/promo_provider.dart';
import 'package:cgheven/screens/detail/all_assets_page.dart';
import 'package:cgheven/services/api_services.dart';
import 'package:cgheven/services/eam.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/animated_container_widget.dart';
import 'package:cgheven/widget/buid_background.dart';
import 'package:cgheven/widget/circular_widget.dart';
import 'package:cgheven/widget/grid_widget.dart';
import 'package:cgheven/widget/promo_widget.dart';
import 'package:cgheven/widget/search_box_widget.dart';
import 'package:cgheven/widget/shimmer_widget.dart';
import 'package:cgheven/widget/view_all_widget.dart';
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
  List<Category> _vfxSubcategories = [];
  bool _isLoadingSubcats = false;
  final AssetApiService _apiService = AssetApiService();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AssetProvider>(context, listen: false).getNewAssets();
      Provider.of<PromoProvider>(context, listen: false).fetchPromos();
      _loadVfxSubcategories();
    });
  }

  Future<void> _loadVfxSubcategories() async {
    setState(() => _isLoadingSubcats = true);
    try {
      final result = await _apiService.fetchCategories();
      setState(() {
        _vfxSubcategories = result;
        if (_vfxSubcategories.isNotEmpty) {
          selectedChip =
              _vfxSubcategories.first.name; // 👈 Preselect first chip
          // Automatically load its assets
          Provider.of<AssetProvider>(
            context,
            listen: false,
          ).getAssetsBySubcategory(selectedChip!);
        }
      });
    } catch (e) {
      print("❌ Failed to fetch subcategories: $e");
    } finally {
      setState(() => _isLoadingSubcats = false);
    }
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
      body: Stack(
        children: [
          buildBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    buildSearchBox(context),
                    const SizedBox(height: 10),
                    _buildSections(),

                    /// 🔹 Updates Section via AnnouncementProvider
                    if (activeAssetSection == 'Updates')
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              : provider.assets.take(10).toList();

                          // ✅ Trending Section
                          if (activeAssetSection == 'Trending\n Assets') {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                    buildGrid(_trendingAssets, context),
                                  ViewAllWidget(),
                                  const SizedBox(height: 10),
                                  PromoWidget(),
                                  const SizedBox(height: 10),

                                  /// 🔹 VFX Subcategories
                                  if (_isLoadingSubcats)
                                    const CircularWidget()
                                  else if (_vfxSubcategories.isNotEmpty) ...[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: _vfxSubcategories.map((cat) {
                                          final isSelected =
                                              selectedChip == cat.name;
                                          return GestureDetector(
                                            onTap: () {
                                              setState(
                                                () => selectedChip = cat.name,
                                              );
                                              Provider.of<AssetProvider>(
                                                context,
                                                listen: false,
                                              ).getAssetsBySubcategory(
                                                cat.name,
                                              );
                                            },
                                            child: AnimatedContainerWidget(
                                              text: cat.name,
                                              isSelected: isSelected,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),

                                    const SizedBox(height: 20),
                                    Consumer<AssetProvider>(
                                      builder: (context, provider, _) {
                                        if (selectedChip == null)
                                          return const SizedBox.shrink();
                                        if (provider.isLoading) {
                                          return CircularWidget();
                                        }

                                        final filteredAssets =
                                            provider.assetsBySubcategory;
                                        if (filteredAssets.isEmpty) {
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              'No assets found for "$selectedChip".',
                                              style: GoogleFonts.inter(
                                                color: Colors.white70,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          );
                                        }

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                            buildGrid(filteredAssets, context),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildGrid(assetsToShow, context),
                                const SizedBox(height: 10),

                                ViewAllWidget(),

                                const SizedBox(height: 10),
                                //Promo Api
                                PromoWidget(),
                                const SizedBox(height: 10),
                                if (_isLoadingSubcats)
                                  const CircularWidget()
                                else if (_vfxSubcategories.isNotEmpty) ...[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: _vfxSubcategories.map((cat) {
                                        final isSelected =
                                            selectedChip == cat.name;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(
                                              () => selectedChip = cat.name,
                                            );
                                            Provider.of<AssetProvider>(
                                              context,
                                              listen: false,
                                            ).getAssetsBySubcategory(cat.name);
                                          },
                                          child: AnimatedContainerWidget(
                                            text: cat.name,
                                            isSelected: isSelected,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),

                                  const SizedBox(height: 20),
                                  Consumer<AssetProvider>(
                                    builder: (context, provider, _) {
                                      if (selectedChip == null) {
                                        return const SizedBox.shrink();
                                      }

                                      if (provider.isLoading) {
                                        return const Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.tealAccent,
                                            ),
                                          ),
                                        );
                                      }

                                      final filteredAssets =
                                          provider.assetsBySubcategory;

                                      if (filteredAssets.isEmpty) {
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            'No assets found for "$selectedChip".',
                                            style: GoogleFonts.inter(
                                              color: Colors.white70,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      }

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                          buildGrid(filteredAssets, context),
                                        ],
                                      );
                                    },
                                  ),
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
        ],
      ),
    );
  }

  /// 🔹 Tabs (New, Trending, Updates)
  Widget _buildSections() {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppTheme.darkBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00bcd4).withOpacity(.3)),
      ),
      child: Row(
        children: ['New\n Assets', 'Trending\n Assets', 'Updates'].map((
          section,
        ) {
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
                } else if (section == 'Updates') {
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
}
