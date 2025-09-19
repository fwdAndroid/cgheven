import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, // 135 degrees = top-left → bottom-right
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0B1C24), // #0b1c24 at 0%
            Color(0xFF1A0F0D), // #1a0f0d at 100%
          ],
        ),
      ),
      child: Stack(
        children: [
          // Teal glow
          Positioned(
            top: 100,
            left: 50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFF14B8A6).withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Orange glow
          Positioned(
            bottom: 100,
            right: 50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFFF97316).withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
