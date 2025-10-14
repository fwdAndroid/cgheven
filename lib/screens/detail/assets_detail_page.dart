import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/provider/analytics_provider.dart';
import 'package:cgheven/widget/asset_preview_widget.dart';
import 'package:cgheven/provider/favourite_provider.dart';
import 'package:cgheven/widget/asset_related_screen.dart';
import 'package:cgheven/widget/build_stats_widget.dart';
import 'package:cgheven/widget/download_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    final analytics = Provider.of<AnalyticsProvider>(context, listen: false);
    analytics.logAssetView(widget.asset.id.toString(), widget.asset.title);

    _incrementAssetViewCount(widget.asset.id);
  }

  Future<void> _incrementAssetViewCount(dynamic assetId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'asset_views_${assetId.toString()}'; // ✅ convert safely
    int currentCount = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, currentCount + 1);
  }

  /// 🔗 Helper function to launch external URLs safely
  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  bool isInstagramClicked = false;
  bool isYoutubeClicked = false;
  bool isTiktokClicked = false;
  bool isTwitterClicked = false;

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
                    Consumer<FavouriteProvider>(
                      builder: (context, favProvider, _) {
                        final isFavourite = favProvider.isFavourite(
                          widget.asset,
                        );
                        return GestureDetector(
                          onTap: () {
                            favProvider.toggleFavourite(widget.asset);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isFavourite
                                  ? Color(0xFFFBBF24).withOpacity(0.2)
                                  : Color(0xFF374151).withOpacity(0.5),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isFavourite
                                    ? Color(0xFFFBBF24).withOpacity(0.3)
                                    : Color(0xFF374151),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              isFavourite ? Icons.star : Icons.star_border,
                              color: isFavourite
                                  ? Color(0xFFFBBF24)
                                  : Color(0xFF9CA3AF),
                              size: 20,
                            ),
                          ),
                        );
                      },
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
              AssetPreviewPlayer(
                videoUrl: widget.asset.previews,
                green_screen: widget.asset.green_screen,
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
                          _socialButton(
                            color: Colors.pinkAccent,
                            clicked: isInstagramClicked,
                            icon: FontAwesomeIcons.instagram,
                            onPressed: () async {
                              setState(
                                () => isInstagramClicked = !isInstagramClicked,
                              );
                              await _launchURL(
                                'https://www.instagram.com/ammarkhaanim',
                              );
                            },
                          ),
                          SizedBox(width: 8),
                          _socialButton(
                            color: Colors.lightBlue,
                            clicked: isTwitterClicked,
                            icon: FontAwesomeIcons.twitter,
                            onPressed: () async {
                              setState(
                                () => isTwitterClicked = !isTwitterClicked,
                              );
                              await _launchURL('https://x.com/ammarkhaanim');
                            },
                          ),
                          SizedBox(width: 8),
                          _socialButton(
                            color: Colors.teal,
                            clicked: isTiktokClicked,
                            icon: FontAwesomeIcons.tiktok,
                            onPressed: () async {
                              setState(
                                () => isTiktokClicked = !isTiktokClicked,
                              );
                              await _launchURL(
                                'https://www.tiktok.com/@ammarkhaanim',
                              );
                            },
                          ),
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
                  titleText: "ProRes 444",
                  options: [
                    Mp4Option(quality: "1K", size: "890 MB", isRewarded: true),
                    Mp4Option(quality: "2K", size: "1.8 GB", isRewarded: true),
                    Mp4Option(quality: "4K", size: "4.2 GB", isRewarded: true),
                  ],
                ),
              ),

              // 🔹 Related Assets Header + Slider
              RelatedAssetsSection(asset: widget.asset),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required Color color,
    required bool clicked,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade900.withOpacity(0.3),
        // borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF00bcd4).withOpacity(.4),
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: FaIcon(icon, size: 20, color: clicked ? color : Colors.white),
      ),
    );
  }

  void shareApp() {
    String appLink =
        "https://play.google.com/store/apps/details?id=com.example.yourapp";
    Share.share("Hey, check out this amazing app: $appLink");
  }
}
