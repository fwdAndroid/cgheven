import 'package:cgheven/provider/announcement_provider.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<AnnouncementProvider>(
        context,
        listen: false,
      ).loadAnnouncements(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Latest Announcements",
                  style: GoogleFonts.poppins(
                    color: Colors.tealAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Consumer<AnnouncementProvider>(
                  builder: (context, provider, _) {
                    if (provider.isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(
                            color: Colors.tealAccent,
                          ),
                        ),
                      );
                    }

                    if (provider.announcements.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "No announcements available.",
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }

                    return Column(
                      children: provider.announcements.map((a) {
                        return Card(
                          color: AppTheme.darkBackground.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                              color: Color(0xFF00bcd4),
                              width: .3,
                            ),
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
                              ),
                            ),
                            title: Text(
                              a.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              a.content.isNotEmpty
                                  ? a.content
                                  : "No description available",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            // trailing: Text(
                            //   a.published,
                            //   style: const TextStyle(
                            //     color: Colors.white54,
                            //     fontSize: 12,
                            //   ),
                            // ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
