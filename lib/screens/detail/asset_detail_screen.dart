import 'package:cgheven/screens/utils/gradient_button.dart';
import 'package:cgheven/widget/gradient_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class AssetDetailScreen extends StatefulWidget {
  AssetDetailScreen({super.key});

  @override
  State<AssetDetailScreen> createState() => _AssetDetailScreenState();
}

class _AssetDetailScreenState extends State<AssetDetailScreen> {
  bool isPlaying = false;
  bool isStarred = false;
  final List<Map<String, String>> relatedAssets = [
    {
      'id': '1',
      'title': 'Fire Explosion 02',
      'thumbnail':
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400',
      'duration': '0:08',
    },
    {
      'id': '2',
      'title': 'Smoke Trail',
      'thumbnail':
          'https://images.pexels.com/photos/590016/pexels-photo-590016.jpg?auto=compress&cs=tinysrgb&w=400',
      'duration': '0:12',
    },
    {
      'id': '3',
      'title': 'Lightning Strike',
      'thumbnail':
          'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400',
      'duration': '0:06',
    },
    {
      'id': '4',
      'title': 'Magic Sparkles',
      'thumbnail':
          'https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=400',
      'duration': '0:15',
    },
  ];

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
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(24),
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

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Video Player
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF1F2937).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFF00bcd4).withOpacity(.4),
                            width: 1,
                          ),
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.network(
                                  'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=1200',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              // Alpha Channel Badge
                              Positioned(
                                top: 16,
                                left: 16,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF14B8A6),
                                        Color(0xFFF97316),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    '✓ Includes Alpha',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // Play Button
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPlaying = !isPlaying;
                                    });
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Icon(
                                      isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 32),

                      // Asset Info
                      Text(
                        'Gas Explosion 01',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader =
                                LinearGradient(
                                  colors: [
                                    Color(0xFF14B8A6),
                                    Color(0xFFF97316),
                                  ],
                                ).createShader(
                                  Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                                ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Professional high-quality gas explosion VFX element perfect for action sequences and cinematic productions. Shot at 120fps with alpha channel included.',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF9CA3AF),
                          fontSize: 18,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 24),

                      // Stats
                      Row(
                        children: [
                          _buildStat(Icons.visibility, '12.4K views'),
                          SizedBox(width: 24),
                          _buildStat(Icons.download, '3.2K downloads'),
                          SizedBox(width: 24),
                          _buildStat(Icons.favorite, '847 likes'),
                        ],
                      ),
                      SizedBox(height: 32),

                      // Creator Info
                      Container(
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
                                  colors: [
                                    Color(0xFF14B8A6),
                                    Color(0xFFF97316),
                                  ],
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
                                _buildSocialButton(
                                  Icons.camera_alt,
                                  Colors.pink,
                                ),
                                SizedBox(width: 8),
                                _buildSocialButton(
                                  Icons.play_circle,
                                  Colors.red,
                                ),
                                SizedBox(width: 8),
                                _buildSocialButton(
                                  Icons.alternate_email,
                                  Colors.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Download Options
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Download Options",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF1F2937).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF00bcd4).withOpacity(.4),
                            width: 1,
                          ),
                        ),
                        child: // MP4 Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "MP4",
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF14B8A6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff0d2b33),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(
                                        0xFF00bcd4,
                                      ).withOpacity(.4),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "1 K",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "125 MB",
                                          style: GoogleFonts.inter(
                                            color: Color(0xff7b8f98),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Download",
                                          style: GoogleFonts.inter(
                                            color: Color(0xff41afa4),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(""),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff201f1d),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(
                                        0xFF503b2b,
                                      ).withOpacity(.4),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "2 K",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "280 MB",
                                          style: GoogleFonts.inter(
                                            color: Color(0xff7b8f98),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "* Rewarded",
                                          style: GoogleFonts.inter(
                                            color: Colors.orangeAccent,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Download",
                                          style: GoogleFonts.inter(
                                            color: Colors.orangeAccent,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff201f1d),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(
                                        0xFF503b2b,
                                      ).withOpacity(.4),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "4 K",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "650 MB",
                                          style: GoogleFonts.inter(
                                            color: Color(0xff7b8f98),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "* Rewarded",
                                          style: GoogleFonts.inter(
                                            color: Colors.orangeAccent,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Download",
                                          style: GoogleFonts.inter(
                                            color: Colors.orangeAccent,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF1F2937).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF00bcd4).withOpacity(.4),
                              width: 1,
                            ),
                          ),
                          child: // MP4 Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "PRORES 444",
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF14B8A6),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff201f1d),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(
                                          0xFF503b2b,
                                        ).withOpacity(.4),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "1 K",
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "650 MB",
                                            style: GoogleFonts.inter(
                                              color: Color(0xff7b8f98),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "* Rewarded",
                                            style: GoogleFonts.inter(
                                              color: Colors.orangeAccent,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Download",
                                            style: GoogleFonts.inter(
                                              color: Colors.orangeAccent,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff201f1d),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(
                                          0xFF503b2b,
                                        ).withOpacity(.4),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "2 K",
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "1.7 GB",
                                            style: GoogleFonts.inter(
                                              color: Color(0xff7b8f98),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "* Rewarded",
                                            style: GoogleFonts.inter(
                                              color: Colors.orangeAccent,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Download",
                                            style: GoogleFonts.inter(
                                              color: Colors.orangeAccent,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff201f1d),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(
                                          0xFF503b2b,
                                        ).withOpacity(.4),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "4 K",
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "2 GB",
                                            style: GoogleFonts.inter(
                                              color: Color(0xff7b8f98),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "* Rewarded",
                                            style: GoogleFonts.inter(
                                              color: Colors.orangeAccent,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Download",
                                            style: GoogleFonts.inter(
                                              color: Colors.orangeAccent,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Ad Banner
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFF1F2937).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF00bcd4).withOpacity(.4),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Advertisement",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Ad Banner Space",
                                    style: GoogleFonts.inter(
                                      color: Color(0xffCDD5E2),
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                      MediaQuery.of(context).size.width,
                                      60,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: Color(0xff3C4556),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Related Assets",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 160,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: relatedAssets.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (_, idx) {
                            final asset = relatedAssets[idx];
                            return SizedBox(
                              width: 180,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          border: Border.all(
                                            color: const Color(
                                              0xFF00bcd4,
                                            ).withOpacity(.4),
                                            width: 1,
                                          ),
                                          color: Colors.white10,
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                child: Image.network(
                                                  asset['thumbnail']!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Container(
                                                color: Colors.black.withOpacity(
                                                  0.35,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                width: 44,
                                                height: 44,
                                                decoration: BoxDecoration(
                                                  color: Colors.white24,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        999,
                                                      ),
                                                ),
                                                child: const Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 8,
                                              right: 8,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  asset['duration']!,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      asset['title']!,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      // Builder(
                      //   builder: (context) {
                      //     final screenWidth = MediaQuery.of(context).size.width;
                      //     const crossAxisCount = 2;
                      //     const spacing = 16.0;

                      //     final totalSpacing = spacing * (crossAxisCount + 1);
                      //     final cardWidth =
                      //         (screenWidth - totalSpacing) / crossAxisCount;
                      //     final cardHeight =
                      //         cardWidth * 1.25; // you can tweak this
                      //     final aspectRatio = cardWidth / cardHeight;

                      //     return GridView.builder(
                      //       shrinkWrap: true,
                      //       physics: const NeverScrollableScrollPhysics(),
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 12,
                      //         vertical: 8,
                      //       ),
                      //       gridDelegate:
                      //           SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: crossAxisCount,
                      //             crossAxisSpacing: spacing,
                      //             mainAxisSpacing: spacing,
                      //             childAspectRatio: aspectRatio,
                      //           ),
                      //       itemBuilder: (context, index) {
                      //         return AssetCard(
                      //           asset: asset,
                      //           onTap: () {
                      //             Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => AssetDetailScreen(),
                      //               ),
                      //             );
                      //           },
                      //         );
                      //       },
                      //     );
                      //   },
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: GradientButton(
                            onPressed: () {},
                            child: Center(
                              child: Text(
                                "Download Now",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ),
                            gradient: LinearGradient(
                              colors: [Color(0xFFF97316), Color(0xFFF97316)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF9CA3AF), size: 16),
        SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(color: Color(0xFF9CA3AF), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFF374151).withOpacity(0.5),
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFF374151), width: 1),
      ),
      child: Icon(icon, color: Color(0xFF9CA3AF), size: 16),
    );
  }

  void shareApp() {
    String appLink =
        "https://play.google.com/store/apps/details?id=com.example.yourapp";
    Share.share("Hey, check out this amazing app: $appLink");
  }
}
