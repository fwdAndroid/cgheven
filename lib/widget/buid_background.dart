import 'package:flutter/material.dart';

Widget buildBackground() {
  return Stack(
    children: [
      // 🌈 Layer 1: Rich 3-color gradient background
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // 135-degree direction
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0B1C24), // cool teal tint (top-left)
              Color(0xFF101820), // neutral dark mid-tone
              Color(0xFF1A0F0D), // warm brown-black (bottom-right)
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
      ),

      // 🌤️ Layer 2: Subtle light overlay for depth
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.03),
              Colors.black.withOpacity(0.2),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.orange.withOpacity(0.1), Colors.transparent],
            radius: 0.7,
            center: const Alignment(0.7, 0.8),
          ),
        ),
      ),
    ],
  );
}
