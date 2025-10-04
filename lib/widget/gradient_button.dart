import 'dart:ui';
import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final LinearGradient gradient;
  final VoidCallback onPressed;
  final Widget child;

  const GradientButton({
    super.key,
    required this.gradient,
    required this.onPressed,
    required this.child,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 150), () {
          setState(() => _pressed = false);
        });
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gradient Background
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (_pressed)
                  BoxShadow(
                    color: widget.gradient.colors.first.withOpacity(0.6),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
            child: widget.child,
          ),

          // Blur Overlay (only visible when pressed)
          if (_pressed)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.white.withOpacity(0.05)),
              ),
            ),
        ],
      ),
    );
  }
}
