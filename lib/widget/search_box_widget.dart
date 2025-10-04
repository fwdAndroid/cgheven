import 'package:cgheven/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildSearchBox(BuildContext context) {
  return Container(
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const SearchPage()),
        // );
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
  );
}
