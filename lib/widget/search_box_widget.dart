import 'package:cgheven/screens/main/pages/download_pages.dart';
import 'package:cgheven/screens/main/pages/search_screen.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildSearchBox(BuildContext context) {
  return Row(
    children: [
      Expanded(
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            style: GoogleFonts.poppins(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search effects, explosions, magic...',
              hintStyle: GoogleFonts.poppins(
                color: const Color(0xFF9CA3AF),
                fontSize: 14,
              ),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ),
      IconButton(
        icon: const Icon(Icons.download, color: Color(0xFF9CA3AF), size: 32),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => DownloadScreen()),
          );
        },
      ),
    ],
  );
}
