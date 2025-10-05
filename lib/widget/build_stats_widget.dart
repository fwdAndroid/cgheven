import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildStat(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, color: Color(0xFF9CA3AF), size: 16),
      SizedBox(width: 4),
      Text(
        text,
        style: GoogleFonts.poppins(color: Color(0xFF9CA3AF), fontSize: 14),
      ),
    ],
  );
}

Widget buildSocialButton(IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Color(0xFF374151).withOpacity(0.5),
      shape: BoxShape.circle,
      border: Border.all(color: Color(0xFF374151), width: 1),
    ),
    child: Icon(icon, color: Color(0xFF9CA3AF), size: 16),
  );
}
