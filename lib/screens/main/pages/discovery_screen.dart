import 'package:cgheven/services/api_services.dart';
import 'package:cgheven/services/eam.dart';
import 'package:cgheven/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  bool isGrid = true;
  late Future<List<Category>> _categoriesFuture;

  // 🔹 Hardcoded thumbnails + description fallback
  final List<Map<String, String>> defaultInfo = [
    {
      "thumbnail":
          "https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=600",
    },
    {
      "thumbnail":
          "https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=600",
    },
    {
      "thumbnail":
          "https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=600",
    },
    {
      "thumbnail":
          "https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=600",
    },
    {
      "thumbnail":
          "https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=600",
    },
  ];

  @override
  void initState() {
    super.initState();
    _categoriesFuture = AssetApiService().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                _buildTitle(),
                const SizedBox(height: 8),
                Expanded(
                  child: FutureBuilder<List<Category>>(
                    future: _categoriesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.tealAccent,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            "Failed to load categories",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "No categories found",
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }

                      final categories = snapshot.data!;
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: isGrid
                            ? _buildGridView(categories)
                            : _buildListView(categories),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🌈 Background
  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF111111), Color(0xFF000000), Color(0xFF111111)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.teal.withOpacity(0.1), Colors.transparent],
              radius: 0.7,
              center: const Alignment(-0.7, -0.6),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.orange.withOpacity(0.1), Colors.transparent],
              radius: 0.7,
              center: const Alignment(0.7, 0.8),
            ),
          ),
        ),
      ],
    );
  }

  // 🔘 Header with grid/list toggle
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900.withOpacity(0.3),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade800),
            ),
            child: Row(
              children: [
                _viewButton(true, Icons.grid_view_rounded),
                _viewButton(false, Icons.list_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🏷️ Title section
  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) => const LinearGradient(
              colors: [Colors.tealAccent, Colors.orangeAccent],
            ).createShader(bounds),
            child: const Text(
              "Categories",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Explore our collection of professional visual effects",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // 🟩 Grid layout
  Widget _buildGridView(List<Category> categories) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final c = categories[index];
        final info = defaultInfo[index % defaultInfo.length];
        return _AnimatedCategoryCard(
          name: c.name,
          thumbnail: info["thumbnail"]!,
          description: "Explore stunning ${c.name} assets and effects",
        );
      },
    );
  }

  // 📋 List layout
  Widget _buildListView(List<Category> categories) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final c = categories[index];
        final info = defaultInfo[index % defaultInfo.length];

        return _CategoryTile(
          name: c.name,
          description: "Explore stunning ${c.name} assets and effects",
          imageUrl: info["thumbnail"]!, // 🔥 Same placeholder
        );
      },
    );
  }

  // Toggle button
  Widget _viewButton(bool grid, IconData icon) {
    final bool active = grid == isGrid;
    return InkWell(
      onTap: () => setState(() => isGrid = grid),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: active
              ? const LinearGradient(colors: [Colors.teal, Colors.orange])
              : null,
          color: active ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: active
              ? [BoxShadow(color: Colors.teal.withOpacity(0.3), blurRadius: 10)]
              : [],
        ),
        child: Icon(icon, color: active ? Colors.white : Colors.grey, size: 22),
      ),
    );
  }
}

// 🔹 Category Tile Widget (for list)
class _CategoryTile extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;

  const _CategoryTile({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF00bcd4), width: .6),
        color: AppTheme.darkBackground.withOpacity(0.6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
      ),
    );
  }
}

// 🎬 Category Card
class _AnimatedCategoryCard extends StatefulWidget {
  final String name;
  final String thumbnail;
  final String description;

  const _AnimatedCategoryCard({
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  @override
  State<_AnimatedCategoryCard> createState() => _AnimatedCategoryCardState();
}

class _AnimatedCategoryCardState extends State<_AnimatedCategoryCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => hovered = true),
      onTapUp: (_) => setState(() => hovered = false),
      onTapCancel: () => setState(() => hovered = false),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade900.withOpacity(0.3),
          border: Border.all(color: Color(0xFF00bcd4), width: .3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.network(
                    widget.thumbnail,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Positioned.fill(
                //   child: AnimatedOpacity(
                //     duration: const Duration(milliseconds: 300),
                //     opacity: hovered ? 0.3 : 0.15,
                //     child: Container(
                //       decoration: const BoxDecoration(
                //         gradient: LinearGradient(
                //           colors: [Colors.teal, Colors.orange],
                //           begin: Alignment.topLeft,
                //           end: Alignment.bottomRight,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Positioned(
                  right: 20,
                  top: 60,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: hovered ? 1 : 0,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
