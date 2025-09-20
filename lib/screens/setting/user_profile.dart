import 'package:flutter/material.dart';
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/screens/detail/asset_detail_screen.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Example favourites
  final List<Asset> allAssets = [
    Asset(
      id: 11,
      title: "Sci-Fi Explosion",
      thumbnail:
          "https://images.pexels.com/photos/7974/fire-orange-emergency-burning.jpg",
      category: "VFX",
      isNew: true,
    ),
    Asset(
      id: 12,
      title: "Lowpoly Car",
      thumbnail:
          "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg",
      category: "Lowpoly",
    ),
  ];

  final List<String> categories = ["VFX", "Lowpoly", "3D Models"];

  // Example downloads
  List<DownloadItem> downloads = [
    DownloadItem(
      id: '1',
      title: 'Gas Explosion 01',
      thumbnail:
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg',
      format: 'MP4',
      quality: '4K',
      size: '650 MB',
      status: DownloadStatus.downloading,
      progress: 67,
      eta: '2m 15s',
    ),
    DownloadItem(
      id: '2',
      title: 'Fire Blast 02',
      thumbnail:
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg',
      format: 'MP4',
      quality: '2K',
      size: '280 MB',
      status: DownloadStatus.completed,
      progress: 100,
      eta: '',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        title: Text(
          "My Profile",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          tabs: const [
            Tab(text: "Favourites"),
            Tab(text: "Downloads"),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
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
        child: TabBarView(
          controller: _tabController,
          children: [_buildFavouriteTab(), _buildDownloadTab()],
        ),
      ),
    );
  }

  /// Favourite Tab
  Widget _buildFavouriteTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: allAssets.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return AssetCard(
            asset: allAssets[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (builder) => AssetDetailScreen()),
              );
            },
          );
        },
      ),
    );
  }

  /// Downloads Tab
  Widget _buildDownloadTab() {
    final activeDownloads = downloads
        .where((d) => d.status != DownloadStatus.completed)
        .toList();
    final completedDownloads = downloads
        .where((d) => d.status == DownloadStatus.completed)
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (activeDownloads.isNotEmpty) ...[
          Text(
            "Current Downloads",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 12),
          ...activeDownloads.map((d) => _buildDownloadItem(d)),
          const SizedBox(height: 24),
        ],
        Text(
          "Download History",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
        ),
        const SizedBox(height: 12),
        if (completedDownloads.isEmpty)
          Center(
            child: Text(
              "No downloads yet",
              style: GoogleFonts.poppins(color: Colors.white70),
            ),
          )
        else
          ...completedDownloads.map((d) => _buildDownloadItem(d)),
      ],
    );
  }

  /// Single Download Item
  Widget _buildDownloadItem(DownloadItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(item.thumbnail, width: 64, height: 64),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                if (item.status != DownloadStatus.completed)
                  LinearProgressIndicator(
                    value: item.progress / 100,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF14B8A6),
                    ),
                    backgroundColor: Colors.white24,
                  )
                else
                  const Text(
                    "Completed",
                    style: TextStyle(color: Colors.greenAccent),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
