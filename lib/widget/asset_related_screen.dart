import 'package:cgheven/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/screens/detail/assets_detail_page.dart';
import 'package:cgheven/widget/asset_card.dart';

class RelatedAssetsSection extends StatelessWidget {
  final AssetModel asset;

  const RelatedAssetsSection({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Consumer<AssetProvider>(
      builder: (context, provider, child) {
        final relatedAssets = provider.assets
            .where((a) => a.categorie == asset.categorie && a.id != asset.id)
            .toList();

        if (relatedAssets.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "No related assets found.",
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        // 🔹 Scroll Controller shared between arrows and list
        final scrollController = ScrollController();

        return StatefulBuilder(
          builder: (context, setInnerState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Header Row (Title + Arrows)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Related Assets",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white70,
                              size: 18,
                            ),
                            onPressed: () {
                              scrollController.animateTo(
                                scrollController.offset - 200,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOutCubic,
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white70,
                              size: 18,
                            ),
                            onPressed: () {
                              scrollController.animateTo(
                                scrollController.offset + 200,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOutCubic,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 🔹 Horizontal Asset List
                SizedBox(
                  height: 220,
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: relatedAssets.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final relatedAsset = relatedAssets[index];
                      return SizedBox(
                        width: 180,
                        child: AssetCard(
                          asset: relatedAsset,
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AssetDetailScreen(asset: relatedAsset),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
