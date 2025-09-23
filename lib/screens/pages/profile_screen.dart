import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/model/user_asset.dart';
import 'package:cgheven/screens/pages/community_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final List<UserAsset> userAssets;
  late final List<Map<String, String>> stats;
  bool isFollowing = false;
  bool isInstagramClicked = false;
  bool isYoutubeClicked = false;
  bool isTiktokClicked = false;
  bool isTwitterClicked = false;

  @override
  void initState() {
    super.initState();
    userAssets = [
      UserAsset(
        id: 1,
        title: 'Epic Fire Blast',
        thumbnail:
            'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '2.3K',
        likes: '456',
      ),
      UserAsset(
        id: 2,
        title: 'Lightning Strike',
        thumbnail:
            'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '1.8K',
        likes: '321',
      ),
      UserAsset(
        id: 3,
        title: 'Smoke Plume',
        thumbnail:
            'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '3.1K',
        likes: '678',
      ),
      UserAsset(
        id: 4,
        title: 'Magic Sparkles',
        thumbnail:
            'https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '1.5K',
        likes: '234',
      ),
      UserAsset(
        id: 5,
        title: 'Dust Cloud',
        thumbnail:
            'https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '2.7K',
        likes: '543',
      ),
      UserAsset(
        id: 6,
        title: 'Debris Scatter',
        thumbnail:
            'https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=400',
        downloads: '1.9K',
        likes: '387',
      ),
    ];

    stats = [
      {'label': 'Assets', 'value': '127'},
      {'label': 'Downloads', 'value': '45.2K'},
      {'label': 'Followers', 'value': '8.9K'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (builder) => CommunityPage()),
              );
            },
            icon: Icon(Icons.notifications, color: Color(0xFF14B8A6)),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Profile Section
                      Column(
                        children: [
                          // Avatar
                          Container(
                            width: 128,
                            height: 128,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
                              ),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: ClipOval(
                              child: Image.network(
                                'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=300',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Name and Title
                          Text(
                            'Ammar Khan',
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
                          const SizedBox(height: 8),
                          Text(
                            'Creator of CGHEVEN VFX',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF9CA3AF),
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // GradientButton(
                              //   gradient: LinearGradient(
                              //     colors: [
                              //       Color(0xFF14B8A6),
                              //       Color(0xFFF97316),
                              //     ],
                              //   ),

                              //   onPressed: () {
                              //     setState(() {
                              //       isFollowing = !isFollowing;
                              //     });
                              //   },
                              //   child: Row(
                              //     children: [
                              //       Icon(
                              //         isFollowing
                              //             ? Icons.check
                              //             : Icons.person_add,
                              //         color: Colors.white,
                              //       ),
                              //       const SizedBox(width: 8),
                              //       Text(
                              //         isFollowing ? "Following" : "Follow",
                              //         style: GoogleFonts.poppins(
                              //           fontSize: 16,
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // const SizedBox(width: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF00bcd4,
                                    ).withOpacity(.4),
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isInstagramClicked = !isInstagramClicked;
                                    });
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.instagram,
                                    size: 30,
                                    color: isInstagramClicked
                                        ? Colors.pinkAccent
                                        : Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              // YouTube
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF00bcd4,
                                    ).withOpacity(.4),
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isYoutubeClicked = !isYoutubeClicked;
                                    });
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.youtube,
                                    size: 30,
                                    color: isYoutubeClicked
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              // TikTok
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF00bcd4,
                                    ).withOpacity(.4),
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isTiktokClicked = !isTiktokClicked;
                                    });
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.tiktok,
                                    size: 30,
                                    color: isTiktokClicked
                                        ? Colors.tealAccent
                                        : Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              // Twitter (X)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF00bcd4,
                                    ).withOpacity(.4),
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isTwitterClicked = !isTwitterClicked;
                                    });
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.twitter,
                                    size: 30,
                                    color: isTwitterClicked
                                        ? Colors.lightBlue
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Stats
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStat('127', 'Assets'),
                              _buildStat('45.2K', 'Downloads'),
                              _buildStat('8.9K', 'Followers'),
                            ],
                          ),

                          // Follow + Socials
                          const SizedBox(height: 20),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFF00bcd4).withOpacity(.4),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Professional VFX artist and creator with over 8 years of experience in cinematic effects. '
                            'Specializing in explosions, fire, smoke, and magical elements for film and television productions. '
                            'Passionate about creating high-quality assets that bring stories to life.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: userAssets.length,
                        itemBuilder: (context, index) {
                          final userAsset = userAssets[index];

                          // Convert UserAsset → Asset
                          final asset = Asset(
                            id: userAsset.id,
                            title: userAsset.title,
                            thumbnail: userAsset.thumbnail,
                            downloads: userAsset.downloads,
                            //  likes: userAsset.likes,
                            category:
                                "VFX", // add default category if UserAsset doesn’t have one
                            isNew:
                                false, // set default if UserAsset doesn’t track this
                          );

                          return AssetCard(asset: asset);
                        },
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

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(color: Color(0xFF9CA3AF), fontSize: 14),
        ),
      ],
    );
  }
}
