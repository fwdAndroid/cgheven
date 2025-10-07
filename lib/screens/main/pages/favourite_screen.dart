import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isGrid = true;

  final List<Map<String, dynamic>> vfxCategories = [
    {
      "id": 1,
      "name": "Fire",
      "icon": LucideIcons.flame,
      "description": "Realistic fire effects and flames",
      "thumbnail":
          "https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=600",
      "assetCount": "47 Assets",
      "gradient": [Colors.red, Colors.orange],
      "glowColor": Colors.redAccent,
      "bgGlow": Colors.redAccent.withOpacity(0.1),
    },
    {
      "id": 2,
      "name": "Explosion",
      "icon": LucideIcons.zap,
      "description": "Dynamic explosion and blast effects",
      "thumbnail":
          "https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=600",
      "assetCount": "32 Assets",
      "gradient": [Colors.yellow, Colors.red],
      "glowColor": Colors.orangeAccent,
      "bgGlow": Colors.orangeAccent.withOpacity(0.1),
    },
    {
      "id": 3,
      "name": "Smoke",
      "icon": LucideIcons.wind,
      "description": "Atmospheric smoke and vapor",
      "thumbnail":
          "https://images.pexels.com/photos/590016/pexels-photo-590016.jpg?auto=compress&cs=tinysrgb&w=600",
      "assetCount": "28 Assets",
      "gradient": [Colors.grey.shade600, Colors.grey.shade800],
      "glowColor": Colors.grey,
      "bgGlow": Colors.grey.withOpacity(0.1),
    },
    {
      "id": 4,
      "name": "Lightning",
      "icon": LucideIcons.zap,
      "description": "Electric bolts and energy effects",
      "thumbnail":
          "https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=600",
      "assetCount": "19 Assets",
      "gradient": [Colors.blue, Colors.purple],
      "glowColor": Colors.blueAccent,
      "bgGlow": Colors.blueAccent.withOpacity(0.1),
    },
    {
      "id": 5,
      "name": "Magic",
      "icon": LucideIcons.sparkles,
      "description": "Mystical and magical elements",
      "thumbnail":
          "https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=600",
      "assetCount": "35 Assets",
      "gradient": [Colors.purple, Colors.pinkAccent],
      "glowColor": Colors.purpleAccent,
      "bgGlow": Colors.purpleAccent.withOpacity(0.1),
    },
    {
      "id": 6,
      "name": "Debris",
      "icon": LucideIcons.mountain,
      "description": "Destruction and particle debris",
      "thumbnail":
          "https://images.pexels.com/photos/956981/milky-way-starry-sky-night-sky-star-956981.jpeg?auto=compress&cs=tinysrgb&w=600",
      "assetCount": "24 Assets",
      "gradient": [Colors.amber, Colors.deepOrange],
      "glowColor": Colors.orange,
      "bgGlow": Colors.orange.withOpacity(0.1),
    },
    {
      "id": 7,
      "name": "Dust",
      "icon": LucideIcons.layers,
      "description": "Fine particles and dust clouds",
      "thumbnail":
          "https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=600",
      "assetCount": "16 Assets",
      "gradient": [Colors.yellow, Colors.amber],
      "glowColor": Colors.yellowAccent,
      "bgGlow": Colors.yellowAccent.withOpacity(0.1),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Subtle gradient background layers
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF111111),
                  Color(0xFF000000),
                  Color(0xFF111111),
                ],
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
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button

                      // View Toggle
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
                ),
                // Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) => LinearGradient(
                          colors: [Colors.tealAccent, Colors.orangeAccent],
                        ).createShader(bounds),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Explore our collection of professional visual effects",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: isGrid
                        ? _buildGridView(context)
                        : _buildListView(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildGridView(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: vfxCategories.length,
      itemBuilder: (context, index) {
        final c = vfxCategories[index];
        return _AnimatedCategoryCard(category: c);
      },
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: vfxCategories.length,
      itemBuilder: (context, index) {
        final c = vfxCategories[index];
        return _AnimatedCategoryTile(category: c);
      },
    );
  }
}

class _AnimatedCategoryCard extends StatefulWidget {
  final Map<String, dynamic> category;
  const _AnimatedCategoryCard({required this.category});

  @override
  State<_AnimatedCategoryCard> createState() => _AnimatedCategoryCardState();
}

class _AnimatedCategoryCardState extends State<_AnimatedCategoryCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.category;
    return GestureDetector(
      onTapDown: (_) => setState(() => hovered = true),
      onTapUp: (_) => setState(() => hovered = false),
      onTapCancel: () => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: c["bgGlow"]),
          boxShadow: [
            BoxShadow(
              color: hovered ? c["glowColor"].withOpacity(0.6) : c["bgGlow"],
              blurRadius: hovered ? 30 : 10,
              spreadRadius: hovered ? 2 : 0,
            ),
          ],
          color: Colors.grey.shade900.withOpacity(0.2),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: Image.network(
                    c["thumbnail"],
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.4),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: hovered ? 0.3 : 0.15,
                    duration: const Duration(milliseconds: 400),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: List<Color>.from(c["gradient"]),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 60,
                  child: AnimatedScale(
                    scale: hovered ? 1.2 : 1,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        border: Border.all(color: Colors.white24),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: c["glowColor"].withOpacity(0.6),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Icon(c["icon"], color: Colors.white, size: 32),
                    ),
                  ),
                ),
                if (hovered)
                  Positioned(
                    right: 20,
                    top: 60,
                    child: AnimatedOpacity(
                      opacity: hovered ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      foreground: hovered
                          ? (Paint()
                              ..shader =
                                  const LinearGradient(
                                    colors: [Colors.teal, Colors.orange],
                                  ).createShader(
                                    const Rect.fromLTWH(0, 0, 200, 70),
                                  ))
                          : null,
                      color: hovered ? null : Colors.white,
                    ),
                    child: Text(c["name"]),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c["description"],
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade700),
                    ),
                    child: Text(
                      c["assetCount"],
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
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

class _AnimatedCategoryTile extends _AnimatedCategoryCard {
  const _AnimatedCategoryTile({required super.category});
}
