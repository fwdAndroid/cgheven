import 'package:flutter/material.dart';
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:cgheven/screens/detail/assets_detail_page.dart';

class AllAssetsPage extends StatelessWidget {
  final List<AssetModel> assets;

  const AllAssetsPage({super.key, required this.assets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1C24),
      appBar: AppBar(
        title: const Text('All VFX Assets'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: assets.isEmpty
          ? const Center(
              child: Text(
                'No assets available.',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          builder: (_) => AssetDetailScreen(asset: asset),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
