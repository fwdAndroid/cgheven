import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/provider/api_provider.dart';
import 'package:cgheven/provider/favourite_provider.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/buid_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  final String categoryName;

  const FavouriteScreen({super.key, required this.categoryName});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isGrid = true;

  // ✅ Remove (VFX) or any parentheses for slug-safe lookups
  String get cleanedCategoryName {
    return widget.categoryName.replaceAll(RegExp(r'\s*\(.*?\)'), '').trim();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Fetch assets from AssetProvider using slug-safe category
    final assets = Provider.of<AssetProvider>(
      context,
      listen: false,
    ).getAssetsBySubcategory(cleanedCategoryName);

    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                _buildTitle(),
                const SizedBox(height: 8),

                // ✅ Favourites Consumer (filtered by slug-safe category)
                Expanded(
                  child: Consumer<FavouriteProvider>(
                    builder: (context, favProvider, _) {
                      final favourites = favProvider.getFavouritesBySubcategory(
                        cleanedCategoryName,
                      );

                      if (favourites.isEmpty) {
                        return Center(
                          child: Text(
                            "No favourites found in \"$cleanedCategoryName\"",
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: isGrid
                            ? _buildGridView(favourites)
                            : _buildListView(favourites),
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

  // 🔘 Header with grid/list toggle buttons
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900.withOpacity(0.3),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade800),
            ),
            child: Row(
              children: [
                _viewButton(true, Icons.grid_view_rounded),
                _viewButton(false, Icons.list_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🏷️ Title section
  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) =>
                AppTheme.fireGradient.createShader(bounds),
            child: Text(
              cleanedCategoryName,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Your saved favourites in this category",
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ],
      ),
    );
  }

  // 🟩 Grid layout
  Widget _buildGridView(List<AssetModel> assets) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: assets.length,
      itemBuilder: (context, index) {
        final asset = assets[index];
        return _AssetCard(asset: asset);
      },
    );
  }

  // 📋 List layout
  Widget _buildListView(List<AssetModel> assets) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: assets.length,
      itemBuilder: (context, index) {
        final asset = assets[index];
        return _AssetTile(asset: asset);
      },
    );
  }

  // 🟦 Toggle button widget
  Widget _viewButton(bool grid, IconData icon) {
    final bool active = grid == isGrid;
    return InkWell(
      onTap: () => setState(() => isGrid = grid),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: active ? AppTheme.fireGradient : null,
          color: active ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: active
              ? [BoxShadow(color: Colors.teal.withOpacity(0.3), blurRadius: 10)]
              : [],
        ),
        child: Icon(icon, color: active ? Colors.white : Colors.grey, size: 22),
      ),
    );
  }
}

//
// 🔹 Asset Card (Grid mode)
//
class _AssetCard extends StatelessWidget {
  final AssetModel asset;

  const _AssetCard({required this.asset});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouriteProvider>(context);
    final isFav = favProvider.isFavourite(asset);

    return GestureDetector(
      onTap: () {
        // TODO: navigate to AssetDetailScreen(asset)
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.tealAccent.withOpacity(0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                asset.thumbnail,
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      asset.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => favProvider.toggleFavourite(asset),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.redAccent : Colors.grey,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// 🔹 Asset Tile (List mode)
//
class _AssetTile extends StatelessWidget {
  final AssetModel asset;

  const _AssetTile({required this.asset});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouriteProvider>(context);
    final isFav = favProvider.isFavourite(asset);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.tealAccent.withOpacity(0.5)),
        color: Colors.grey.shade900.withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            asset.thumbnail,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          asset.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          asset.description ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        trailing: IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.redAccent : Colors.grey,
          ),
          onPressed: () => favProvider.toggleFavourite(asset),
        ),
      ),
    );
  }
}
