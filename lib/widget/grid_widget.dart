import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/screens/detail/assets_detail_page.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:flutter/material.dart';

Widget buildGrid(List<AssetModel> assets, BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  const crossAxisCount = 2;
  const spacing = 16.0;
  final totalSpacing = spacing * (crossAxisCount + 1);
  final cardWidth = (screenWidth - totalSpacing - 24) / crossAxisCount;
  final cardHeight = cardWidth * 0.9;
  final aspectRatio = cardWidth / cardHeight;

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.only(top: 12, bottom: 12),
    itemCount: assets.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      childAspectRatio: aspectRatio,
    ),
    itemBuilder: (context, index) {
      final asset = assets[index];
      return AssetCard(
        asset: asset,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => AssetDetailScreen(asset: asset),
            ),
          );
        },
      );
    },
  );
}
