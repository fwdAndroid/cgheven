import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class _DownloadSelectorState extends State<DownloadSelector> {
  int selectedIndex = -1;

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
              // Small handle at top
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 20),

              // Gift icon
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

              // Title
              Text(
                "Watch Ad to Download",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                "You’re about to download ${option.quality} (${option.size})",
                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Rewarded Info Box
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

              // Buttons Row
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(100, 75),
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

                  // Watch Ad Button (with gradient)
                  Expanded(
                    child: GradientButton(
                      gradient: AppTheme.fireGradient,
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: trigger your rewarded ad logic here
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
          // Title
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

          // Row of MP4 options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(widget.options.length, (index) {
              final option = widget.options[index];
              final bool isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedIndex = index);
                  _showRewardedSheet(context, option);
                },
                child: Container(
                  width: 110,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xff201f1d),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF00BCD4)
                          : const Color(0xFF503b2b).withOpacity(.4),
                      width: 1,
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
  }
}
