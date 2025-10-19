import 'package:cgheven/provider/analytics_provider.dart';
import 'package:cgheven/provider/poll_provider.dart';
import 'package:cgheven/screens/tab/community_page.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/buid_background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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

  bool isInstagramClicked = false;
  bool isYoutubeClicked = false;
  bool isTiktokClicked = false;
  bool isTwitterClicked = false;
  String activeAssetSection = 'Polls'; // default active tab

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final analytics = Provider.of<AnalyticsProvider>(context, listen: false);
      analytics.logProfileVisit();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PollProvider>(context, listen: false).fetchPolls();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          buildBackground(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        /// 👤 Profile Section
                        _buildProfileHeader(),

                        const SizedBox(height: 20),

                        /// 📊 Stats
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStat('127', 'Assets'),
                            _buildStat('45.2K', 'Downloads'),
                            _buildStat('8.9K', 'Followers'),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// 📝 Bio
                        _buildBio(),

                        /// 🔘 Section Tabs
                        _buildTabs(),

                        /// 🗳️ Polls or Announcements
                        if (activeAssetSection == 'Polls')
                          _buildPollsSection(context)
                        else
                          const CommunityPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- PROFILE HEADER ----------------
  Widget _buildProfileHeader() {
    return Column(
      children: [
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
        Text(
          'Ammar Khan',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = AppTheme.fireGradient.createShader(
                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Creator of CGHEVEN VFX',
          style: GoogleFonts.poppins(
            color: const Color(0xFF9CA3AF),
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 32),

        /// 🌐 Social Icons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton(
              icon: FontAwesomeIcons.instagram,
              color: Colors.pinkAccent,
              clicked: isInstagramClicked,
              onPressed: () async {
                setState(() => isInstagramClicked = !isInstagramClicked);
                await _launchURL('https://www.instagram.com/ammarkhaanim');
              },
            ),
            const SizedBox(width: 10),
            _socialButton(
              icon: FontAwesomeIcons.youtube,
              color: Colors.red,
              clicked: isYoutubeClicked,
              onPressed: () async {
                setState(() => isYoutubeClicked = !isYoutubeClicked);
                await _launchURL('https://www.youtube.com/AmmarKhanim');
              },
            ),
            const SizedBox(width: 10),
            _socialButton(
              icon: FontAwesomeIcons.tiktok,
              color: Colors.tealAccent,
              clicked: isTiktokClicked,
              onPressed: () async {
                setState(() => isTiktokClicked = !isTiktokClicked);
                await _launchURL('https://www.tiktok.com/@ammarkhaanim');
              },
            ),
            const SizedBox(width: 10),
            _socialButton(
              icon: FontAwesomeIcons.twitter,
              color: Colors.lightBlue,
              clicked: isTwitterClicked,
              onPressed: () async {
                setState(() => isTwitterClicked = !isTwitterClicked);
                await _launchURL('https://x.com/ammarkhaanim');
              },
            ),
          ],
        ),
      ],
    );
  }

  /// ---------------- POLL SECTION ----------------
  Widget _buildPollsSection(BuildContext context) {
    return Padding(
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
          Consumer<PollProvider>(
            builder: (context, pollProvider, _) {
              if (pollProvider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                );
              } else if (pollProvider.error != null) {
                return Center(child: Text("Error: ${pollProvider.error}"));
              } else if (pollProvider.polls.isEmpty) {
                return const Center(
                  child: Text(
                    "No polls available right now.",
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }

              return Column(
                children: pollProvider.polls.map((poll) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(
                          color: Color(0xFF00bcd4),
                          width: .3,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              poll.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...poll.options.entries.map((entry) {
                              final isSelected =
                                  pollProvider.selectedOptions[poll.id] ==
                                  entry.key;

                              return InkWell(
                                onTap: () {
                                  pollProvider.selectOption(poll.id, entry.key);
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: isSelected
                                        ? AppTheme.fireGradient
                                        : null,
                                    color: isSelected ? null : Colors.grey[850],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.orangeAccent
                                          : Colors.transparent,
                                      width: 1.2,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: Colors.orange.withOpacity(
                                                0.4,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        entry.value,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      if (isSelected)
                                        const Icon(
                                          Icons.local_fire_department,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: 6),
                            Text(
                              "Ends on: ${poll.endDate ?? 'N/A'}",
                              style: const TextStyle(
                                color: Colors.tealAccent,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  /// ----------------- SUPPORTING UI -----------------
  Widget _socialButton({
    required IconData icon,
    required Color color,
    required bool clicked,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF00bcd4).withOpacity(.4),
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: FaIcon(icon, size: 30, color: clicked ? color : Colors.white),
      ),
    );
  }

  Widget _buildBio() {
    return Padding(
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
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  setState(() => activeAssetSection = section);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: isActive ? AppTheme.fireGradient : null,
                    color: isActive ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      section,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
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
              ..shader = const LinearGradient(
                colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFF9CA3AF),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
