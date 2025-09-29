import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<String> votedRequests = [];
  bool showRequestForm = false;
  String requestTitle = '';
  String requestDescription = '';

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
                ...announcements.map(
                  (a) => Card(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                        color: Color(0xFF00bcd4),
                        width: .3,
                      ),
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
                      side: const BorderSide(
                        color: Color(0xFF00bcd4),
                        width: .3,
                      ),

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

          // floatingActionButton: FloatingActionButton(
          //   onPressed: () => setState(() => showRequestForm = true),
          //   backgroundColor: Colors.teal,
          //   child: const Icon(Icons.add),
          // ),
        ],
      ),
    );
  }
}
