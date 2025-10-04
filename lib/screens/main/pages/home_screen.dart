import 'package:cgheven/provider/api_provider.dart';
import 'package:cgheven/screens/detail/assets_detail_page.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeAssetSection = 'New\n Assets';

  @override
  void initState() {
    super.initState();
    // Fetch latest assets initially
    Future.microtask(
      () => Provider.of<AssetProvider>(context, listen: false).getNewAssets(),
    );
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

                /// 🔹 Sections (New, Trending, News)
                _buildSections(),

                /// 🔹 Assets Grid
                Consumer<AssetProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(80.0),
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.cyan),
                        ),
                      );
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

                    return Builder(
                      builder: (context) {
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
                          padding: const EdgeInsets.all(12),
                          itemCount: provider.assets.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: spacing,
                                mainAxisSpacing: spacing,
                                childAspectRatio: aspectRatio,
                              ),
                          itemBuilder: (context, index) {
                            final asset = provider.assets[index];
                            return AssetCard(
                              asset: asset,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) =>
                                        AssetDetailScreen(asset: asset),
                                  ),
                                );
                                // You can navigate to detail screen later
                              },
                            );
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
      ),
    );
  }

  /// 🔘 Section Tabs
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
                  } else if (section == 'Trending\n Assets') {
                    // Implement trending API here later
                  } else if (section == 'News') {
                    // Implement news API here later
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
}
