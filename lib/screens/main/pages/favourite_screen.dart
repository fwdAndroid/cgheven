import 'package:cgheven/screens/detail/assets_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cgheven/provider/favourite_provider.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1C24),
      appBar: AppBar(
        title: Text(
          'Favourites',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // 135 degrees = top-left → bottom-right
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0B1C24), // #0b1c24 at 0%
              Color(0xFF1A0F0D), // #1a0f0d at 100%
            ],
          ),
        ),
        child: Consumer<FavouriteProvider>(
          builder: (context, favProvider, _) {
            final favourites = favProvider.favourites;

            if (favourites.isEmpty) {
              return const Center(
                child: Text(
                  'No favourites yet 💫',
                  style: TextStyle(color: Colors.white54),
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
                    (screenWidth - totalSpacing - 24) /
                    crossAxisCount; // subtract 24px for global padding
                final cardHeight = cardWidth * 0.9;
                final aspectRatio = cardWidth / cardHeight;
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    childAspectRatio: aspectRatio,
                  ),
                  itemCount: favourites.length,
                  itemBuilder: (context, index) {
                    final asset = favourites[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) =>
                                AssetDetailScreen(asset: asset),
                          ),
                        );
                      },
                      child: AssetCard(asset: asset),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
