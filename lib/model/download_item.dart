class DownloadItem {
  final String id;
  final String title;
  final String thumbnail;
  final String format;
  final String quality;
  final String size;
  String status; // downloading, paused, completed, failed, queued
  int progress;
  String eta;
  String? error;

  DownloadItem({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.format,
    required this.quality,
    required this.size,
    required this.status,
    required this.progress,
    required this.eta,
    this.error,
  });
}
