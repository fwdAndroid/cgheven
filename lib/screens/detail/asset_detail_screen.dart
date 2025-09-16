import 'package:cgheven/screens/utils/gradient_button.dart';
import 'package:cgheven/widget/animated_background.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
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
                            color: Color(0xFF374151),
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
                            color: Color(0xFF374151),
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
                      SizedBox(height: 50),
                      SizedBox(
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
                            colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
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
