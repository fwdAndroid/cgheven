import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/build_stats_widget.dart';
import 'package:cgheven/widget/download_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class AssetDetailScreen extends StatefulWidget {
  final AssetModel asset;

  AssetDetailScreen({super.key, required this.asset});

  @override
  State<AssetDetailScreen> createState() => _AssetDetailScreenState();
}

class _AssetDetailScreenState extends State<AssetDetailScreen> {
  bool isPlaying = false;
  bool isStarred = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back, color: Color(0xFF9CA3AF)),
                          SizedBox(width: 8),
                          Text(
                            'Back',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF9CA3AF),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isStarred = !isStarred;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isStarred
                              ? Color(0xFFFBBF24).withOpacity(0.2)
                              : Color(0xFF374151).withOpacity(0.5),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isStarred
                                ? Color(0xFFFBBF24).withOpacity(0.3)
                                : Color(0xFF374151),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          isStarred ? Icons.star : Icons.star_border,
                          color: isStarred
                              ? Color(0xFFFBBF24)
                              : Color(0xFF9CA3AF),
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        shareApp();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF374151).withOpacity(0.5),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF374151),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.share,
                          color: Color(0xFF9CA3AF),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.darkBackground.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF00bcd4),
                      width: 0.3,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment
                        .center, // ✅ ensures play button is perfectly centered

                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            "https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=1200",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00E676), Color(0xFFFF7043)],
                            ),
                          ),
                          child: const Text(
                            '✓ Includes Alpha',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPlaying = !isPlaying;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              border: Border.all(color: Colors.white30),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: 0.3,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.teal, Colors.orange],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "0:03 / 0:08",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8),
                child: Text(
                  widget.asset.title,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12,
                  top: 8,
                  bottom: 12,
                ),
                child: const Text(
                  "Professional high-quality gas explosion VFX element perfect for action sequences, destruction scenes, and cinematic productions. Shot at 120fps for smooth slow-motion playback with alpha channel included for seamless compositing.",
                  style: TextStyle(color: Colors.white70, height: 1.4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12,
                  top: 4,
                  bottom: 12,
                ),
                child: Row(
                  children: [
                    buildStat(Icons.visibility, '12.4K views'),
                    SizedBox(width: 24),
                    buildStat(Icons.download, '3.2K downloads'),
                    SizedBox(width: 24),
                    buildStat(Icons.favorite, '847 likes'),
                  ],
                ),
              ),

              // Creator Info
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12,
                  top: 8,
                  bottom: 12,
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF1F2937).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF00bcd4).withOpacity(.4),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(2),
                        child: ClipOval(
                          child: Image.network(
                            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=100',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Created by Ammar Khan',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'VFX Artist & Director',
                              style: GoogleFonts.poppins(
                                color: Color(0xFF9CA3AF),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          buildSocialButton(Icons.camera_alt, Colors.pink),
                          SizedBox(width: 8),
                          buildSocialButton(Icons.play_circle, Colors.red),
                          SizedBox(width: 8),
                          buildSocialButton(Icons.alternate_email, Colors.blue),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Text(
                  "Download Options",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 12,
                ),
                child: DownloadSelector(
                  titleText: "MP4",
                  options: [
                    Mp4Option(quality: "1K", size: "125 MB"),
                    Mp4Option(quality: "2K", size: "280 MB", isRewarded: true),
                    Mp4Option(quality: "4K", size: "650 MB", isRewarded: true),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 12,
                ),
                child: DownloadSelector(
                  titleText: "MP4",
                  options: [
                    Mp4Option(quality: "1K", size: "125 MB"),
                    Mp4Option(quality: "2K", size: "280 MB", isRewarded: true),
                    Mp4Option(quality: "4K", size: "650 MB", isRewarded: true),
                  ],
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  void shareApp() {
    String appLink =
        "https://play.google.com/store/apps/details?id=com.example.yourapp";
    Share.share("Hey, check out this amazing app: $appLink");
  }
}
