import 'package:cgheven/provider/pagination_provider.dart';
import 'package:cgheven/widget/search_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:cgheven/screens/detail/assets_detail_page.dart';

class AllAssetsPage extends StatefulWidget {
  const AllAssetsPage({super.key});

  @override
  State<AllAssetsPage> createState() => _AllAssetsPageState();
}

class _AllAssetsPageState extends State<AllAssetsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<PaginatedAssetProvider>(
      context,
      listen: false,
    );
    provider.fetchInitial();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        provider.fetchMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int getResponsiveCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 500) return 2; // small phones
    if (width < 800) return 3; // large phones / small tablets
    if (width < 1200) return 4; // tablets
    return 5; // large screens / desktops
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1C24),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'All VFX Assets',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<PaginatedAssetProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.assets.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.tealAccent),
            );
          }

          if (provider.assets.isEmpty) {
            return const Center(
              child: Text(
                'No assets found.',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          final crossAxisCount = getResponsiveCrossAxisCount(context);
          final spacing = 12.0;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                buildSearchBox(context),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: 0.85, // consistent card ratio
                    ),
                    itemCount: provider.hasMore
                        ? provider.assets.length + 1
                        : provider.assets.length,
                    itemBuilder: (context, index) {
                      if (index >= provider.assets.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.tealAccent,
                            ),
                          ),
                        );
                      }

                      final asset = provider.assets[index];
                      return AssetCard(
                        asset: asset,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AssetDetailScreen(asset: asset),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
