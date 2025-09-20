import 'package:cgheven/model/asset_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  int activeTabIndex = 0;
  List<DownloadItem> downloads = [
    DownloadItem(
      id: '1',
      title: 'Gas Explosion 01',
      thumbnail:
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400',
      format: 'MP4',
      quality: '4K',
      size: '650 MB',
      status: DownloadStatus.downloading,
      progress: 67,
      eta: '2m 15s',
    ),
    DownloadItem(
      id: '2',
      title: 'Lightning Strike',
      thumbnail:
          'https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400',
      format: 'ProRes 444',
      quality: '2K',
      size: '1.8 GB',
      status: DownloadStatus.paused,
      progress: 23,
      eta: '8m 45s',
    ),
    DownloadItem(
      id: '3',
      title: 'Fire Blast 02',
      thumbnail:
          'https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400',
      format: 'MP4',
      quality: '2K',
      size: '280 MB',
      status: DownloadStatus.completed,
      progress: 100,
      eta: '',
    ),
  ];

  List<DownloadItem> get activeDownloads => downloads
      .where((item) => item.status != DownloadStatus.completed)
      .toList();

  List<DownloadItem> get completedDownloads => downloads
      .where((item) => item.status == DownloadStatus.completed)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Downloads',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                ),
              ),

              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF374151),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildTab('Current', Icons.download, 0),
                      _buildTab('History', Icons.check_circle, 1),
                      _buildTab('Manage', Icons.storage, 2),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Tab Content
              Expanded(child: _buildTabContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title, IconData icon, int index) {
    final isActive = activeTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            activeTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
                  )
                : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : const Color(0xFF9CA3AF),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: isActive ? Colors.white : const Color(0xFF9CA3AF),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (activeTabIndex) {
      case 0:
        return _buildCurrentDownloads();
      case 1:
        return _buildHistory();
      case 2:
        return _buildManage();
      default:
        return _buildCurrentDownloads();
    }
  }

  Widget _buildCurrentDownloads() {
    if (activeDownloads.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.download, size: 64, color: Color(0xFF6B7280)),
            SizedBox(height: 16),
            Text(
              'No Active Downloads',
              style: GoogleFonts.poppins(
                color: Color(0xFF9CA3AF),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your current downloads will appear here',
              style: GoogleFonts.poppins(
                color: Color(0xFF6B7280),
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: activeDownloads.length,
      itemBuilder: (context, index) {
        final item = activeDownloads[index];
        return _buildDownloadItem(item);
      },
    );
  }

  Widget _buildHistory() {
    if (completedDownloads.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 64, color: Color(0xFF6B7280)),
            SizedBox(height: 16),
            Text(
              'No Download History',
              style: GoogleFonts.poppins(
                color: Color(0xFF9CA3AF),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Completed downloads will appear here',
              style: GoogleFonts.poppins(
                color: Color(0xFF6B7280),
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                'Download History',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    downloads.removeWhere(
                      (item) => item.status == DownloadStatus.completed,
                    );
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Color(0xFFEF4444),
                  size: 16,
                ),
                label: Text(
                  'Clear History',
                  style: GoogleFonts.poppins(
                    color: Color(0xFFEF4444),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: completedDownloads.length,
            itemBuilder: (context, index) {
              final item = completedDownloads[index];
              return _buildDownloadItem(item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildManage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Bulk Actions
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937).withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF374151), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bulk Actions',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3,
                  children: [
                    _buildActionButton(
                      'Pause All',
                      Icons.pause,
                      const Color(0xFFFBBF24),
                    ),
                    _buildActionButton(
                      'Resume All',
                      Icons.play_arrow,
                      const Color(0xFF14B8A6),
                    ),
                    _buildActionButton(
                      'Cancel All',
                      Icons.close,
                      const Color(0xFFEF4444),
                    ),
                    _buildActionButton(
                      'Clear History',
                      Icons.delete,
                      const Color(0xFF6B7280),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Storage Management
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937).withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF374151), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.storage,
                      color: Color(0xFF14B8A6),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Storage Management',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  '2.4 GB of 8.0 GB used',
                  style: GoogleFonts.poppins(
                    color: Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF374151),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.3,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0 GB',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '30% used',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '8.0 GB',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Handle action
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadItem(DownloadItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937).withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF374151), width: 1),
      ),
      child: Row(
        children: [
          // Thumbnail with status
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF374151),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.thumbnail,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Center(child: _getStatusIcon(item.status)),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      item.size,
                      style: GoogleFonts.poppins(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    _buildChip(item.format),
                    const SizedBox(width: 8),
                    _buildChip(item.quality),
                    if (item.eta.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text(
                        'ETA: ${item.eta}',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),

                if (item.status != DownloadStatus.completed) ...[
                  const SizedBox(height: 12),
                  // Progress Bar
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.status == DownloadStatus.failed
                                ? 'Failed'
                                : '${item.progress}%',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF9CA3AF),
                              fontSize: 12,
                            ),
                          ),
                          if (item.error != null)
                            Text(
                              item.error!,
                              style: GoogleFonts.poppins(
                                color: Color(0xFFEF4444),
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: item.progress / 100,
                        backgroundColor: const Color(0xFF374151),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getStatusColor(item.status),
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 12),
                // Action Buttons
                Row(children: _buildActionButtons(item)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF374151).withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF374151), width: 1),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(color: Color(0xFF9CA3AF), fontSize: 12),
      ),
    );
  }

  Icon _getStatusIcon(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.downloading:
        return const Icon(Icons.download, color: Color(0xFF14B8A6), size: 16);
      case DownloadStatus.paused:
        return const Icon(Icons.pause, color: Color(0xFFFBBF24), size: 16);
      case DownloadStatus.completed:
        return const Icon(
          Icons.check_circle,
          color: Color(0xFF10B981),
          size: 16,
        );
      case DownloadStatus.failed:
        return const Icon(Icons.error, color: Color(0xFFEF4444), size: 16);
      case DownloadStatus.queued:
        return const Icon(Icons.schedule, color: Color(0xFF9CA3AF), size: 16);
    }
  }

  Color _getStatusColor(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.downloading:
        return const Color(0xFF14B8A6);
      case DownloadStatus.paused:
        return const Color(0xFFFBBF24);
      case DownloadStatus.completed:
        return const Color(0xFF10B981);
      case DownloadStatus.failed:
        return const Color(0xFFEF4444);
      case DownloadStatus.queued:
        return const Color(0xFF9CA3AF);
    }
  }

  List<Widget> _buildActionButtons(DownloadItem item) {
    List<Widget> buttons = [];

    if (item.status == DownloadStatus.downloading) {
      buttons.add(
        _buildActionButton('Pause', Icons.pause, const Color(0xFFFBBF24)),
      );
    } else if (item.status == DownloadStatus.paused) {
      buttons.add(
        _buildActionButton('Resume', Icons.play_arrow, const Color(0xFF14B8A6)),
      );
    } else if (item.status == DownloadStatus.failed) {
      buttons.add(
        _buildActionButton('Retry', Icons.refresh, const Color(0xFFF97316)),
      );
    } else if (item.status == DownloadStatus.completed) {
      buttons.add(
        _buildActionButton('Open', Icons.folder_open, const Color(0xFF10B981)),
      );
    }

    if (item.status != DownloadStatus.completed) {
      if (buttons.isNotEmpty) buttons.add(const SizedBox(width: 8));
      buttons.add(
        _buildActionButton('Cancel', Icons.close, const Color(0xFFEF4444)),
      );
    } else {
      if (buttons.isNotEmpty) buttons.add(const SizedBox(width: 8));
      buttons.add(
        _buildActionButton('Delete', Icons.delete, const Color(0xFFEF4444)),
      );
    }

    return buttons;
  }
}
