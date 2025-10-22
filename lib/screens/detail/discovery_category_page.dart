import 'package:cgheven/provider/api_provider.dart';
import 'package:cgheven/screens/detail/assets_detail_page.dart';
import 'package:cgheven/screens/main/pages/favourite_screen.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/buid_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/widget/asset_card.dart';

class DiscoveryCategoryPage extends StatefulWidget {
  final String categoryName;
  const DiscoveryCategoryPage({super.key, required this.categoryName});

  @override
  State<DiscoveryCategoryPage> createState() => _DiscoveryCategoryPageState();
}

class _DiscoveryCategoryPageState extends State<DiscoveryCategoryPage> {
  bool isGrid = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAssets();
  }

  Future<void> _fetchAssets() async {
    final cleanName = widget.categoryName
        .replaceAll(RegExp(r'\s*\(.*?\)'), '')
        .trim();

    await Provider.of<AssetProvider>(
      context,
      listen: false,
    ).getAssetsBySubcategory(cleanName);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.tealAccent,
                          ),
                        )
                      : Consumer<AssetProvider>(
                          builder: (context, assetProvider, _) {
                            final assets = assetProvider.assets;

                            if (assets.isEmpty) {
                              return const Center(
                                child: Text(
                                  "No assets found for this category",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              );
                            }

                            final screenWidth = MediaQuery.of(
                              context,
                            ).size.width;
                            const crossAxisCount = 2;
                            const spacing = 16.0;
                            final totalSpacing = spacing * (crossAxisCount + 1);
                            final cardWidth =
                                (screenWidth - totalSpacing - 24) /
                                crossAxisCount;
                            final cardHeight = cardWidth * 0.9;
                            final aspectRatio = cardWidth / cardHeight;

                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: isGrid
                                  ? GridView.builder(
                                      key: const ValueKey("gridView"),
                                      padding: const EdgeInsets.all(12),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: crossAxisCount,
                                            crossAxisSpacing: spacing,
                                            mainAxisSpacing: spacing,
                                            childAspectRatio: aspectRatio,
                                          ),
                                      itemCount: assets.length,
                                      itemBuilder: (context, index) {
                                        final asset = assets[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (builder) =>
                                                    AssetDetailScreen(
                                                      asset: asset,
                                                    ),
                                              ),
                                            );
                                          },
                                          child: AssetCard(
                                            asset: asset,
                                            isFavorite: false,
                                            onFavoriteToggle: () {},
                                          ),
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      key: const ValueKey("listView"),
                                      padding: const EdgeInsets.all(8),
                                      itemCount: assets.length,
                                      itemBuilder: (context, index) {
                                        final asset = assets[index];
                                        return _buildAssetTile(asset);
                                      },
                                    ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetTile(AssetModel asset) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.darkBackground.withOpacity(0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF00bcd4).withOpacity(.8)),
        ),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => AssetDetailScreen(asset: asset),
              ),
            );
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(asset.thumbnail, width: 60, fit: BoxFit.cover),
          ),
          title: Text(asset.title, style: const TextStyle(color: Colors.white)),
          subtitle: Text(
            "Explore stunning ${widget.categoryName} assets and effects",
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),

          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade900.withOpacity(0.3),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade800),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _viewButton(true, Icons.grid_view_rounded),
                _viewButton(false, Icons.list_rounded),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => FavouriteScreen(
                          categoryName: widget.categoryName
                            ..replaceAll(RegExp(r'\s*\(.*?\)'), '').trim(),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.favorite, color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _viewButton(bool grid, IconData icon) {
    final bool active = grid == isGrid;
    return InkWell(
      onTap: () => setState(() => isGrid = grid),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: active ? AppTheme.fireGradient : null,
          color: active ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: active
          //     ? [BoxShadow(color: Colors.teal.withOpacity(0.3), blurRadius: 10)]
          //     : [],
        ),
        child: Icon(icon, color: active ? Colors.white : Colors.grey, size: 22),
      ),
    );
  }
}
