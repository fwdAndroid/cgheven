import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/provider/favourite_provider.dart';
import 'package:cgheven/widget/asset_card.dart';

class DiscoveryCategoryPage extends StatefulWidget {
  final String categoryName;

  const DiscoveryCategoryPage({super.key, required this.categoryName});

  @override
  State<DiscoveryCategoryPage> createState() => _DiscoveryCategoryPageState();
}

class _DiscoveryCategoryPageState extends State<DiscoveryCategoryPage> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list_rounded : Icons.grid_view_rounded),
            onPressed: () => setState(() => isGrid = !isGrid),
          ),
        ],
      ),
      body: Consumer<FavouriteProvider>(
        builder: (context, favProvider, _) {
          // Get favorites filtered by this category/subcategory
          final favAssets = favProvider.getFavouritesBySubcategory(
            widget.categoryName,
          );

          if (favAssets.isEmpty) {
            return const Center(
              child: Text(
                "No favorite assets found",
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isGrid
                ? GridView.builder(
                    key: const ValueKey("gridView"),
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.85,
                        ),
                    itemCount: favAssets.length,
                    itemBuilder: (context, index) {
                      final asset = favAssets[index];
                      return AssetCard(
                        asset: asset,
                        isFavorite: true,
                        onFavoriteToggle: () =>
                            favProvider.toggleFavourite(asset),
                      );
                    },
                  )
                : ListView.builder(
                    key: const ValueKey("listView"),
                    padding: const EdgeInsets.all(8),
                    itemCount: favAssets.length,
                    itemBuilder: (context, index) {
                      final asset = favAssets[index];
                      return _buildAssetTile(asset, favProvider);
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _buildAssetTile(AssetModel asset, FavouriteProvider favProvider) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(asset.thumbnail, width: 60, fit: BoxFit.cover),
      ),
      title: Text(asset.title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(
        asset.description,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: IconButton(
        icon: Icon(
          favProvider.isFavourite(asset)
              ? Icons.favorite
              : Icons.favorite_border,
          color: favProvider.isFavourite(asset)
              ? Colors.redAccent
              : Colors.white,
        ),
        onPressed: () => favProvider.toggleFavourite(asset),
      ),
    );
  }
}
