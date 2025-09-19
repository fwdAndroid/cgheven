import 'dart:ui'; // for ImageFilter
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/screens/utils/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class AssetCard extends StatelessWidget {
  final Asset asset;
  final VoidCallback? onTap;
  final bool showBadge;

  const AssetCard({
    super.key,
    required this.asset,
    this.onTap,
    this.showBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFF0d0c0b), // inside card dark color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: Color(0xFF00bcd4), // outline color
            width: .3,
          ),
        ),
        elevation: 6, // shadow depth
        shadowColor: Colors.black.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: asset.thumbnail,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: const Color(0xFF374151),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF14B8A6),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: const Color(0xFF374151),
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
            ),
            // Title + Category
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    asset.title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    asset.category,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 12,
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
