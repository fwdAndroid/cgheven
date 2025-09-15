import 'package:cgheven/screens/detail/asset_detail_screen.dart';
import 'package:cgheven/widget/animated_background.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:flutter/material.dart';
import 'package:cgheven/model/asset_model.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Example favourite assets (replace with data from your DB / Provider)
  final List<Asset> allAssets = [
    Asset(
      id: 11,
      title: "Sci-Fi Explosion",
      thumbnail:
          "https://images.pexels.com/photos/7974/fire-orange-emergency-burning.jpg",
      category: "VFX",
      isNew: true,
    ),
    Asset(
      id: 12,
      title: "VBX Motion Pack",
      thumbnail:
          "https://images.pexels.com/photos/257904/pexels-photo-257904.jpeg",
      category: "VOBS",
    ),
    Asset(
      id: 13,
      title: "Lowpoly Car",
      thumbnail:
          "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg",
      category: "Lowpoly",
    ),
    Asset(
      id: 14,
      title: "3D Model Tree",
      thumbnail:
          "https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg",
      category: "3D Models",
    ),
    Asset(
      id: 15,
      title: "Game Asset Pack",
      thumbnail:
          "https://images.pexels.com/photos/1148998/pexels-photo-1148998.jpeg",
      category: "Game Assets",
    ),
  ];

  final List<String> categories = [
    "VFX",
    "VOBS",
    "3D Models",
    "Lowpoly",
    "Game Assets",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  List<Asset> getCurrentAssets(String category) {
    return allAssets.where((a) => a.category == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black.withOpacity(0.5),
          elevation: 0,
          title: const Text(
            "Favourite Assets",
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            tabs: categories.map((c) => Tab(text: c)).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: categories.map((category) {
            final assets = getCurrentAssets(category);

            if (assets.isEmpty) {
              return const Center(
                child: Text(
                  "No favourites in this category",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: assets.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return AssetCard(
                    asset: assets[index],
                    onTap: () {
                      // TODO: Navigate to detail screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => AssetDetailScreen(),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
