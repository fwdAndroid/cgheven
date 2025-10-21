import 'dart:ui';
import 'package:cgheven/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
      child: Stack(
        children: [
          // Blurred Animated Background Circles
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.25,
            child: _blurredCircle(
              gradient: AppTheme.fireGradient,
              size: 120,
              duration: 2000,
              delay: 0,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.33,
            right: MediaQuery.of(context).size.width * 0.25,
            child: _blurredCircle(
              gradient: AppTheme.tealGradient,
              size: 160,
              duration: 2000,
              delay: 1000,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            left: MediaQuery.of(context).size.width * 0.5,
            child: _blurredCircle(
              gradient: AppTheme.logoGradient,
              size: 96,
              duration: 2000,
              delay: 2000,
            ),
          ),

          // Floating Particles
          ...List.generate(6, (index) {
            return Positioned(
              top: (index * 100.0) + 80,
              left: (index.isEven
                  ? 50.0
                  : MediaQuery.of(context).size.width - 70),
              child:
                  Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: index.isEven
                              ? AppTheme.tealStart
                              : AppTheme.fireStart,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .fadeIn(duration: 1000.ms, delay: (index * 500).ms)
                      .fadeOut(
                        duration: 1000.ms,
                        delay: (index * 500 + 1000).ms,
                      ),
            );
          }),

          // Foreground Content
          child,
        ],
      ),
    );
  }

  /// Helper to create a blurred, fading, animated circle
  Widget _blurredCircle({
    required Gradient gradient,
    required double size,
    required int duration,
    required int delay,
  }) {
    return ClipOval(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(size / 2),
            ),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .fadeIn(duration: duration.ms, delay: delay.ms)
        .fadeOut(duration: duration.ms, delay: (delay + 2000).ms);
  }
}
