import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgheven/screens/utils/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final List<Map<String, dynamic>> videos = [
    {
      "title": "Epic Fire Blast",
      "thumbnail": "https://picsum.photos/id/1011/400/250",
      "tag": "Fire",
      "duration": "0:08",
      "quality": "4K",
      "size": "650 MB",
      "isFav": true,
    },
    {
      "title": "Lightning Strike",
      "thumbnail": "https://picsum.photos/id/1015/400/250",
      "tag": "Lightning",
      "duration": "0:06",
      "quality": "4K",
      "size": "480 MB",
      "isFav": true,
    },
    {
      "title": "Epic Fire Blast",
      "thumbnail": "https://picsum.photos/id/1011/400/250",
      "tag": "Fire",
      "duration": "0:08",
      "quality": "4K",
      "size": "650 MB",
      "isFav": false,
    },
    {
      "title": "Lightning Strike",
      "thumbnail": "https://picsum.photos/id/1015/400/250",
      "tag": "Lightning",
      "duration": "0:06",
      "quality": "4K",
      "size": "480 MB",
      "isFav": false,
    },

    {
      "title": "Epic Fire Blast",
      "thumbnail": "https://picsum.photos/id/1011/400/250",
      "tag": "Fire",
      "duration": "0:08",
      "quality": "4K",
      "size": "650 MB",
      "isFav": false,
    },
    {
      "title": "Lightning Strike",
      "thumbnail": "https://picsum.photos/id/1015/400/250",
      "tag": "Lightning",
      "duration": "0:06",
      "quality": "4K",
      "size": "480 MB",
      "isFav": true,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Name and Title
                Text(
                  'Favourite',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          Color(0xFF2A7B9B), // teal-ish
                          Color(0xFF57C785), // green-ish
                          Color(0xFFEDDD53), // yellow-ish
                        ],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                ),
                SizedBox(
                  height: 800,
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8, // adjust height ratio
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      return Card(
                        color: AppTheme.darkBackground.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xFF00bcd4),
                            width: .3,
                          ),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black.withOpacity(0.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Thumbnail with overlays
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: video["thumbnail"],
                                    height: 90,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Favorite button
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        video["isFav"] = !video["isFav"];
                                      });
                                    },
                                    child: Icon(
                                      video["isFav"]
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.redAccent,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                // Tag
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      video["tag"],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                // Duration
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      video["duration"],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                // Play button overlay
                                const Positioned.fill(
                                  child: Center(
                                    child: Icon(
                                      Icons.play_circle_fill,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Title
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              child: Text(
                                video["title"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // Quality & Size
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                "${video["quality"]} • ${video["size"]}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),

                            // Unified Buttons
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xff113332),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.visibility,
                                            color: Color(0xff249081),
                                            size: 15,
                                          ),
                                          const SizedBox(width: 6),

                                          Text(
                                            "Preview",
                                            style: GoogleFonts.inter(
                                              color: Color(0xff249081),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  InkWell(
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xff432815),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xff492916),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.download,
                                            color: Color(0xff8f5425),
                                            size: 15,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            "Download",
                                            style: GoogleFonts.inter(
                                              color: Color(0xff70421f),
                                              fontSize: 12,
                                            ),
                                          ),
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
