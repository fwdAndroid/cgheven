import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

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
      debugPrint("Submitting request: $requestTitle | $requestDescription");
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
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400',
    },
    {
      'id': '2',
      'title': 'Lightning Collection Update',
      'date': '1 week ago',
      'body':
          'Added 12 new lightning strike variations with enhanced branching patterns.',
      'assetLink': 'Lightning Collection',
      'thumbnail':
          'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400',
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

  final requests = [
    {
      'id': 'req1',
      'title': 'Underwater Explosion Effects',
      'description':
          'Need realistic underwater explosion effects with bubble trails and pressure waves.',
      'votes': 127,
      'status': 'Planned',
      'submittedBy': 'Community',
    },
    {
      'id': 'req2',
      'title': 'Neon Energy Shields',
      'description':
          'Sci-fi energy shield effects with customizable colors and impact reactions.',
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),

      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                // Announcements
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),

                      Text(
                        "Latest Announcements",
                        style: GoogleFonts.poppins(
                          color: Colors.tealAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...announcements.map(
                        (a) => Card(
                          color: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
                              ),
                            ),
                            title: Text(
                              a['title']!,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              a['body']!,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: Image.network(
                              a['thumbnail']!,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Polls
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
                        final hasVoted = votedPolls.contains(poll['id']);
                        return Card(
                          color: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  poll['question']!.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...(poll['options'] as List).asMap().entries.map(
                                  (entry) {
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
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 6,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: hasVoted
                                              ? Colors.grey[800]
                                              : Colors.grey[850],
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                                                    style: const TextStyle(
                                                      color: Colors.tealAccent,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            if (hasVoted)
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  top: 6,
                                                ),
                                                height: 6,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.tealAccent
                                                      .withOpacity(0.3),
                                                ),
                                                child: FractionallySizedBox(
                                                  widthFactor: percent / 100.0,
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                                              Colors.orange,
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
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // Requests
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Feature Requests",
                        style: GoogleFonts.poppins(
                          color: Colors.tealAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...requests.map((r) {
                        final voted = votedRequests.contains(r['id']);
                        return Card(
                          color: Colors.grey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        r['title']!.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: getStatusColor(
                                          r['status']!.toString(),
                                        ).withOpacity(0.2),
                                      ),
                                      child: Text(
                                        r['status']!.toString(),
                                        style: TextStyle(
                                          color: getStatusColor(
                                            r['status']!.toString(),
                                          ),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  r['description']!.toString(),
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: voted
                                        ? Colors.teal.withOpacity(0.3)
                                        : Colors.grey[850],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () =>
                                      handleRequestVote(r['id']!.toString()),
                                  icon: const Icon(
                                    Icons.people,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  label: Text(
                                    "${r['votes'].toString()}",
                                    style: const TextStyle(color: Colors.white),
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
              ],
            ),
          ),

          // Modal form
          if (showRequestForm)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Submit Feature Request",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.tealAccent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: (v) => requestTitle = v,
                        decoration: const InputDecoration(
                          hintText: "Effect Title",
                          filled: true,
                          fillColor: Colors.black26,
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: (v) => requestDescription = v,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: "Description",
                          filled: true,
                          fillColor: Colors.black26,
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  setState(() => showRequestForm = false),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: submitRequest,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                              ),
                              child: const Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => showRequestForm = true),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
