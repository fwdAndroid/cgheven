import 'package:cgheven/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:cgheven/screens/detail/assets_detail_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AllAssetsPage extends StatelessWidget {
  final List<AssetModel> assets;

  const AllAssetsPage({super.key, required this.assets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1C24),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'All VFX Assets',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0B1C24),
        elevation: 0,
      ),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
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
                  style: GoogleFonts.poppins(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search effects, explosions, magic...',
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xFF9CA3AF),
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
            assets.isEmpty
                ? const Center(
                    child: Text(
                      'No assets available.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.9,
                            ),
                        itemCount: assets.length,
                        itemBuilder: (context, index) {
                          final asset = assets[index];
                          return AssetCard(
                            asset: asset,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AssetDetailScreen(asset: asset),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
