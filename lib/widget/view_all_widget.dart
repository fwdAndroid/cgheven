import 'package:cgheven/screens/detail/all_assets_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAllWidget extends StatelessWidget {
  const ViewAllWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AllAssetsPage()),
          );
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.tealAccent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.white.withOpacity(0.8),
              Colors.tealAccent.withOpacity(0.8),
              Colors.white.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          blendMode: BlendMode.srcATop,
          child: Text(
            "View All →",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.tealAccent,
              shadows: [
                Shadow(
                  blurRadius: 8,
                  color: Colors.tealAccent.withOpacity(0.5),
                  offset: const Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
