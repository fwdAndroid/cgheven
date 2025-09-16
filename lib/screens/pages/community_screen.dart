import 'package:cgheven/screens/utils/gradient_button.dart';
import 'package:cgheven/widget/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<String> votedPolls = [];
  List<String> votedRequests = [];
  bool showRequestForm = false;
  String requestTitle = '';
  String requestDescription = '';

  void handlePollVote(String pollId, int optionIndex) {
    if (!votedPolls.contains(pollId)) {
      setState(() {
        votedPolls.add(pollId);
      });
      debugPrint("Voted for option $optionIndex in poll $pollId");
    }
  }

  void handleRequestVote(String requestId) {
    setState(() {
      if (votedRequests.contains(requestId)) {
        votedRequests.remove(requestId);
      } else {
        votedRequests.add(requestId);
      }
    });
  }

  void submitRequest() {
    if (requestTitle.trim().isNotEmpty &&
        requestDescription.trim().isNotEmpty) {
      debugPrint("Submitting request: $requestTitle - $requestDescription");
      setState(() {
        requestTitle = '';
        requestDescription = '';
        showRequestForm = false;
      });
    }
  }

  final announcements = [
    {
      'id': '1',
      'title': 'New Fire Pack V3.0 Released',
      'date': '2 days ago',
      'body':
          'Enhanced fire simulations with improved alpha channels and 8K resolution support.',
      'assetLink': 'Fire Pack V3.0',
      'thumbnail':
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg',
    },
    {
      'id': '2',
      'title': 'Lightning Collection Update',
      'date': '1 week ago',
      'body':
          'Added 12 new lightning strike variations with enhanced branching patterns.',
      'assetLink': 'Lightning Collection',
      'thumbnail':
          'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg',
    },
  ];

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
  ];

  final requests = [
    {
      'id': 'req1',
      'title': 'Underwater Explosion Effects',
      'description': 'Need realistic underwater explosion effects...',
      'votes': 127,
      'status': 'Planned',
      'submittedBy': 'Community',
    },
    {
      'id': 'req2',
      'title': 'Neon Energy Shields',
      'description': 'Sci-fi energy shield effects...',
      'votes': 89,
      'status': 'In-Progress',
      'submittedBy': 'Community',
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Planned':
        return Colors.blueAccent;
      case 'In-Progress':
        return Colors.orangeAccent;
      case 'Released':
        return Colors.greenAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),
              // Header
              const SizedBox(height: 16),

              // Announcements
              Text(
                "Latest Announcements",
                style: GoogleFonts.poppins(
                  color: Colors.teal,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...announcements.map((a) {
                return Card(
                  color: Colors.grey[900],
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(a['thumbnail']!),
                    ),
                    title: Text(
                      a['title']!,
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    subtitle: Text(
                      a['body']!,
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                    trailing: Text(
                      a['date']!,
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Polls
              Text(
                "Community Polls",
                style: GoogleFonts.poppins(
                  color: Colors.teal,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...polls.map((p) {
                return Card(
                  color: Colors.grey[850],
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p['question']!.toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...(p['options'] as List).map((opt) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[800],
                              ),
                              onPressed: () {
                                handlePollVote(p['id'].toString(), 0);
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  opt['text'],
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Feature Requests
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Feature Requests",
                    style: GoogleFonts.poppins(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GradientButton(
                    gradient: LinearGradient(
                      colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
                    ),
                    onPressed: () {
                      setState(() {
                        showRequestForm = true;
                      });
                    },
                    child: Text(
                      "Submit Request",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...requests.map((r) {
                return Card(
                  color: Colors.grey[900],
                  child: ListTile(
                    title: Text(
                      r['title']!.toString(),
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    subtitle: Text(
                      r['description']!.toString(),
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          r['status']!.toString(),
                          style: GoogleFonts.poppins(
                            color: getStatusColor(r['status']!.toString()),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${r['votes']} votes",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
