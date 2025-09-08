import 'package:cgheven/model/category.dart';
import 'package:cgheven/screens/utils/color.dart';
import 'package:cgheven/screens/utils/gradient_color_utils.dart';
import 'package:flutter/material.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  bool isGridView = true;

  late final List<VFXCategory> categories;

  @override
  void initState() {
    super.initState();
    categories = [
      VFXCategory(
        id: 1,
        name: 'Fire',
        icon: Icons.local_fire_department,
        description: 'Realistic fire effects and flames',
        thumbnail:
            'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=600',
        assetCount: '47 Assets',
        gradient: const LinearGradient(colors: [Colors.red, Colors.orange]),
        glowColor: Colors.red.withOpacity(0.4),
        bgGlow: Colors.red.withOpacity(0.1),
      ),
      VFXCategory(
        id: 2,
        name: 'Explosion',
        icon: Icons.bolt,
        description: 'Dynamic explosion and blast effects',
        thumbnail:
            'https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=600',
        assetCount: '32 Assets',
        gradient: const LinearGradient(colors: [Colors.yellow, Colors.red]),
        glowColor: Colors.orange.withOpacity(0.4),
        bgGlow: Colors.orange.withOpacity(0.1),
      ),
      VFXCategory(
        id: 3,
        name: 'Smoke',
        icon: Icons.cloud,
        description: 'Atmospheric smoke and vapor',
        thumbnail:
            'https://images.pexels.com/photos/590016/pexels-photo-590016.jpg?auto=compress&cs=tinysrgb&w=600',
        assetCount: '28 Assets',
        gradient: const LinearGradient(colors: [Colors.grey, Colors.black]),
        glowColor: Colors.grey.withOpacity(0.4),
        bgGlow: Colors.grey.withOpacity(0.1),
      ),
      VFXCategory(
        id: 4,
        name: 'Lightning',
        icon: Icons.flash_on,
        description: 'Electric bolts and energy effects',
        thumbnail:
            'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=600',
        assetCount: '19 Assets',
        gradient: const LinearGradient(colors: [Colors.blue, Colors.purple]),
        glowColor: Colors.blue.withOpacity(0.4),
        bgGlow: Colors.blue.withOpacity(0.1),
      ),
      VFXCategory(
        id: 5,
        name: 'Magic',
        icon: Icons.auto_awesome,
        description: 'Mystical and magical elements',
        thumbnail:
            'https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=600',
        assetCount: '35 Assets',
        gradient: const LinearGradient(colors: [Colors.purple, Colors.pink]),
        glowColor: Colors.purple.withOpacity(0.4),
        bgGlow: Colors.purple.withOpacity(0.1),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: GradientText(
          "Discovery",
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          gradient: const LinearGradient(
            colors: [Color(0xFF2A7B9B), Color(0xFF57C785), Color(0xFFEDDD53)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => isGridView = true),
            icon: Icon(
              Icons.grid_view,
              color: isGridView ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () => setState(() => isGridView = false),
            icon: Icon(
              Icons.list,
              color: !isGridView ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: isGridView
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3,
                  mainAxisSpacing: 16,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryCard(category: category);
                },
              )
            : ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CategoryCard(category: category),
                  );
                },
              ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final VFXCategory category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.grey.shade900.withOpacity(0.3),
            border: Border.all(color: category.bgGlow),
            boxShadow: [BoxShadow(color: category.bgGlow, blurRadius: 30)],
          ),
          child: Row(
            children: [
              // Icon with glow
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(color: category.glowColor, blurRadius: 20),
                    ],
                  ),
                  child: Icon(category.icon, color: Colors.white, size: 32),
                ),
              ),
              // Thumbnail
              // Container(
              //   width: 80,
              //   height: 80,
              //   margin: const EdgeInsets.only(right: 16),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(16),
              //     image: DecorationImage(
              //       image: NetworkImage(category.thumbnail),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      category.description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade700),
                        ),
                        child: Text(
                          category.assetCount,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              ),
              // Play Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: const Icon(Icons.play_arrow, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
