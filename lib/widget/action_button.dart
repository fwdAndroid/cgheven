import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget actionBtn(String label, IconData icon, Color color, VoidCallback onTap) {
  return ElevatedButton.icon(
    onPressed: onTap,
    icon: Icon(icon, size: 14, color: color),
    label: Text(label, style: GoogleFonts.poppins(color: color, fontSize: 12)),
    style: ElevatedButton.styleFrom(
      backgroundColor: color.withOpacity(0.15),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      minimumSize: Size.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
