import 'package:cgheven/model/download_item.dart';
import 'package:cgheven/screens/utils/color.dart';
import 'package:cgheven/screens/utils/gradient_color_utils.dart';
import 'package:cgheven/widget/action_button.dart';
import 'package:flutter/material.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  late List<DownloadItem> downloads;
  double storageUsed = 2.4;
  double storageTotal = 8.0;

  @override
  void initState() {
    super.initState();
    downloads = [
      DownloadItem(
        id: "1",
        title: "Gas Explosion 01",
        thumbnail:
            "https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400",
        format: "MP4",
        quality: "4K",
        size: "650 MB",
        status: "downloading",
        progress: 67,
        eta: "2m 15s",
      ),
      DownloadItem(
        id: "2",
        title: "Lightning Strike",
        thumbnail:
            "https://images.pexels.com/photos/1446076/pexels-photo-1446076.jpeg?auto=compress&cs=tinysrgb&w=400",
        format: "ProRes 444",
        quality: "2K",
        size: "1.8 GB",
        status: "paused",
        progress: 23,
        eta: "8m 45s",
      ),
      DownloadItem(
        id: "3",
        title: "Smoke Plume",
        thumbnail:
            "https://images.pexels.com/photos/266808/pexels-photo-266808.jpeg?auto=compress&cs=tinysrgb&w=400",
        format: "MP4",
        quality: "4K",
        size: "720 MB",
        status: "failed",
        progress: 45,
        eta: "",
        error: "Rewarded ad not completed",
      ),
      DownloadItem(
        id: "4",
        title: "Magic Sparkles",
        thumbnail:
            "https://images.pexels.com/photos/1261728/pexels-photo-1261728.jpeg?auto=compress&cs=tinysrgb&w=400",
        format: "MP4",
        quality: "1K",
        size: "125 MB",
        status: "queued",
        progress: 0,
        eta: "Waiting...",
      ),
    ];
  }

  void handleAction(String id, String action) {
    setState(() {
      downloads = downloads
          .map((item) {
            if (item.id == id) {
              switch (action) {
                case "pause":
                  item.status = "paused";
                  break;
                case "resume":
                  item.status = "downloading";
                  break;
                case "retry":
                  item.status = "downloading";
                  item.progress = 0;
                  item.error = null;
                  break;
                case "cancel":
                  return null;
                case "open":
                  debugPrint("Opening ${item.title}");
                  break;
              }
            }
            return item;
          })
          .whereType<DownloadItem>()
          .toList();
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "downloading":
        return Colors.teal;
      case "paused":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "failed":
        return Colors.red;
      case "queued":
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Widget buildDownloadItem(DownloadItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail with icon overlay without Stack
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(item.thumbnail),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black26,
                  BlendMode.darken,
                ), // overlay effect
              ),
            ),
            child: Center(
              child: Icon(
                item.status == "completed"
                    ? Icons.check_circle
                    : Icons.download,
                color: getStatusColor(item.status),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & size
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      item.size,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Format + Quality + ETA
                Row(
                  children: [
                    Chip(
                      label: Text(item.format),
                      backgroundColor: Colors.grey.shade800,
                      labelStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Chip(
                      label: Text(item.quality),
                      backgroundColor: Colors.grey.shade800,
                      labelStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    if (item.eta.isNotEmpty && item.status != "completed")
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "ETA: ${item.eta}",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),

                // Progress bar
                if (item.status != "completed")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${item.progress}%",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          if (item.error != null)
                            Text(
                              item.error!,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: item.progress / 100,
                        backgroundColor: Colors.grey.shade700,
                        valueColor: AlwaysStoppedAnimation(
                          getStatusColor(item.status),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),

                // Action buttons
                Wrap(
                  spacing: 8,
                  children: [
                    if (item.status == "downloading")
                      actionBtn("Pause", Icons.pause, Colors.amber, () {
                        handleAction(item.id, "pause");
                      }),
                    if (item.status == "paused")
                      actionBtn("Resume", Icons.play_arrow, Colors.teal, () {
                        handleAction(item.id, "resume");
                      }),
                    if (item.status == "failed")
                      actionBtn("Retry", Icons.refresh, Colors.orange, () {
                        handleAction(item.id, "retry");
                      }),
                    if (item.status == "completed")
                      actionBtn("Open", Icons.folder_open, Colors.green, () {
                        handleAction(item.id, "open");
                      }),
                    if (item.status != "completed")
                      actionBtn("Cancel", Icons.close, Colors.red, () {
                        handleAction(item.id, "cancel");
                      }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStorageMeter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.sd_storage, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    "Storage",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                "${storageUsed.toStringAsFixed(1)} GB of ${storageTotal.toStringAsFixed(1)} GB used",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: storageUsed / storageTotal,
            backgroundColor: Colors.grey.shade700,
            valueColor: const AlwaysStoppedAnimation(Colors.orange),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "0 GB",
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Text(
                "${((storageUsed / storageTotal) * 100).toStringAsFixed(1)}% used",
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Text(
                "${storageTotal.toStringAsFixed(1)} GB",
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: GradientText(
          "Download",
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          gradient: const LinearGradient(
            colors: [Color(0xFF2A7B9B), Color(0xFF57C785), Color(0xFFEDDD53)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 110,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xff1C212A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade900.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete_outline_rounded, color: colorWhite),
                  Text("Clear Cache", style: TextStyle(color: colorWhite)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Downloads list
          SizedBox(
            height: 400,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: downloads.length,
              itemBuilder: (context, index) {
                return buildDownloadItem(downloads[index]);
              },
            ),
          ),
          // Storage Meter
          Padding(
            padding: const EdgeInsets.all(16),
            child: buildStorageMeter(),
          ),
        ],
      ),
    );
  }
}
