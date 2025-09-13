import 'package:cgheven/screens/utils/apptheme.dart';
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
          // Animated Background Elements
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.25,
            child:
                Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: AppTheme.fireGradient,
                        borderRadius: BorderRadius.circular(60),
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(duration: 2000.ms)
                    .fadeOut(duration: 2000.ms, delay: 2000.ms),
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.33,
            right: MediaQuery.of(context).size.width * 0.25,
            child:
                Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        gradient: AppTheme.tealGradient,
                        borderRadius: BorderRadius.circular(80),
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(duration: 2000.ms, delay: 1000.ms)
                    .fadeOut(duration: 2000.ms, delay: 3000.ms),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            left: MediaQuery.of(context).size.width * 0.5,
            child:
                Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        gradient: AppTheme.logoGradient,
                        borderRadius: BorderRadius.circular(48),
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(duration: 2000.ms, delay: 2000.ms)
                    .fadeOut(duration: 2000.ms, delay: 4000.ms),
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

          // Main Content
          child,
        ],
      ),
    );
  }
}
