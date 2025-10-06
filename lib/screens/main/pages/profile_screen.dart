import 'package:cgheven/screens/tab/community_page.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  late final List<Map<String, String>> stats;
  bool isFollowing = false;
  bool isInstagramClicked = false;
  bool isYoutubeClicked = false;
  bool isTiktokClicked = false;
  bool isTwitterClicked = false;
  List<String> votedPolls = [];

  String activeAssetSection = 'Polls'; // default active tab
  void handlePollVote(String pollId, int optionIndex) {
    if (!votedPolls.contains(pollId)) {
      setState(() {
        votedPolls.add(pollId);
      });
      debugPrint("Voted for option $optionIndex in poll $pollId");
    }
  }

  final polls = [
    {
      'id': 'poll1',
      'question': 'Which VFX category should we expand next?',
      'options': [
        {'text': 'Water & Ocean Effects', 'votes': 234},
        {'text': 'Weather & Storms', 'votes': 189},
        {'text': 'Space & Cosmic', 'votes': 156},
        {'text': 'Destruction & Debris', 'votes': 98},
      ],
      'totalVotes': 677,
      'endsOn': 'Dec 15, 2024',
    },
    {
      'id': 'poll2',
      'question': 'Preferred default download quality?',
      'options': [
        {'text': '1K (Fast Download)', 'votes': 145},
        {'text': '2K (Balanced)', 'votes': 298},
        {'text': '4K (Best Quality)', 'votes': 187},
      ],
      'totalVotes': 630,
      'endsOn': 'Dec 20, 2024',
    },
  ];

  @override
  void initState() {
    super.initState();

    stats = [
      {'label': 'Assets', 'value': '127'},
      {'label': 'Downloads', 'value': '45.2K'},
      {'label': 'Followers', 'value': '8.9K'},
    ];
  }

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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                  onPressed: () async {
                                    setState(
                                      () => isInstagramClicked =
                                          !isInstagramClicked,
                                    );
                                    await _launchURL(
                                      'https://www.instagram.com/ammarkhaanim',
                                    );
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
                                  onPressed: () async {
                                    setState(
                                      () =>
                                          isYoutubeClicked = !isYoutubeClicked,
                                    );
                                    await _launchURL(
                                      'https://www.youtube.com/AmmarKhanim',
                                    );
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
                                  onPressed: () async {
                                    setState(
                                      () => isTiktokClicked = !isTiktokClicked,
                                    );
                                    await _launchURL(
                                      'https://www.tiktok.com/@ammarkhaanim',
                                    );
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
                                  onPressed: () async {
                                    setState(
                                      () =>
                                          isTwitterClicked = !isTwitterClicked,
                                    );
                                    await _launchURL(
                                      'https://x.com/ammarkhaanim',
                                    );
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
                      const SizedBox(height: 10),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppTheme.darkBackground.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF00bcd4).withOpacity(.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: ['Polls', 'Announcements'].map((section) {
                              final isActive = activeAssetSection == section;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      activeAssetSection = section;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.all(
                                      6,
                                    ), // spacing from edges
                                    decoration: BoxDecoration(
                                      gradient: isActive
                                          ? AppTheme.fireGradient
                                          : null,
                                      color: isActive
                                          ? null
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        section,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: isActive
                                              ? FontWeight.w700
                                              : FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      if (activeAssetSection == 'Polls')
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Community Polls",
                                style: GoogleFonts.poppins(
                                  color: Colors.tealAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ...polls.map((poll) {
                                final hasVoted = votedPolls.contains(
                                  poll['id'],
                                );
                                return Card(
                                  color: Colors.grey[900],
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Color(0xFF00bcd4),
                                      width: .3,
                                    ),

                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          poll['question']!.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ...(poll['options'] as List).asMap().entries.map((
                                          entry,
                                        ) {
                                          final index = entry.key;
                                          final option = entry.value;
                                          final percent =
                                              ((option['votes'] /
                                                          poll['totalVotes']) *
                                                      100)
                                                  .round();

                                          return GestureDetector(
                                            onTap: () => handlePollVote(
                                              poll['id']!.toString(),
                                              index,
                                            ),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 6,
                                                  ),
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: hasVoted
                                                    ? Colors.grey[800]
                                                    : Colors.grey[850],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        option['text'],
                                                        style: TextStyle(
                                                          color: hasVoted
                                                              ? Colors.grey[300]
                                                              : Colors.white,
                                                        ),
                                                      ),
                                                      if (hasVoted)
                                                        Text(
                                                          "$percent%",
                                                          style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .tealAccent,
                                                              ),
                                                        ),
                                                    ],
                                                  ),
                                                  if (hasVoted)
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            top: 6,
                                                          ),
                                                      height: 6,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                        color: Colors.tealAccent
                                                            .withOpacity(0.3),
                                                      ),
                                                      child: FractionallySizedBox(
                                                        widthFactor:
                                                            percent / 100.0,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            gradient:
                                                                const LinearGradient(
                                                                  colors: [
                                                                    Colors.teal,
                                                                    Colors
                                                                        .orange,
                                                                  ],
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        )
                      else if (activeAssetSection == 'Announcements')
                        CommunityPage(),
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
