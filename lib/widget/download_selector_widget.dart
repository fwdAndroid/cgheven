import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/gradient_button.dart';

class Mp4Option {
  final String quality;
  final String size;
  final bool isRewarded;

  Mp4Option({
    required this.quality,
    required this.size,
    this.isRewarded = false,
  });
}

class DownloadSelector extends StatefulWidget {
  final String titleText;
  final List<Mp4Option> options;

  const DownloadSelector({
    Key? key,
    required this.titleText,
    required this.options,
  }) : super(key: key);

  @override
  State<DownloadSelector> createState() => _DownloadSelectorState();
}

class _DownloadSelectorState extends State<DownloadSelector>
    with SingleTickerProviderStateMixin {
  int selectedIndex = -1;
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showRewardedSheet(BuildContext context, Mp4Option option) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111827),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.fireGradient,
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Watch Ad to Download",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You’re about to download ${option.quality} (${option.size})",
                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.08),
                  border: Border.all(
                    color: Colors.orangeAccent.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      "🎁 Rewarded Ad Required",
                      style: GoogleFonts.poppins(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Watch a short ad to unlock this high-quality download",
                      style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF374151)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GradientButton(
                      gradient: AppTheme.fireGradient,
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Trigger rewarded ad logic
                      },
                      child: Text(
                        "Watch Ad & Download",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 44),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937).withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF00bcd4).withOpacity(.4),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.titleText,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF14B8A6),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // --- Option Containers ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(widget.options.length, (index) {
                  final option = widget.options[index];
                  final bool isSelected = selectedIndex == index;

                  final innerColor = index == 0
                      ? const Color(0xFF0C2B31)
                      : const Color(0xFF211D1A);
                  final borderColor = index == 0
                      ? const Color(0xFF0C2A31)
                      : const Color(0xFF201B18);

                  final glowColor = index == 0
                      ? const Color(0xFF00BCD4).withOpacity(0.8)
                      : const Color(0xFFF97316).withOpacity(0.8);

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = index);
                      if (option.isRewarded) {
                        Future.delayed(const Duration(milliseconds: 200), () {
                          _showRewardedSheet(context, option);
                        });
                      } else {
                        // Normal download logic here
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 105,
                      height: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [
                                  glowColor.withOpacity(0.25),
                                  innerColor,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: glowColor,
                              blurRadius: 20 + _glowAnimation.value,
                              spreadRadius: 3 + _glowAnimation.value / 2,
                              offset: const Offset(0, 0),
                            )
                          else
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                        ],
                        color: innerColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? (index == 0
                                    ? const Color(0xFF00BCD4)
                                    : const Color(0xFFF97316))
                              : borderColor,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            option.quality,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            option.size,
                            style: GoogleFonts.inter(
                              color: const Color(0xff7b8f98),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (option.isRewarded)
                            Text(
                              "🎁 Rewarded",
                              style: GoogleFonts.inter(
                                color: Colors.orangeAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.download,
                                color: Colors.orangeAccent,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Download",
                                style: GoogleFonts.inter(
                                  color: Colors.orangeAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
