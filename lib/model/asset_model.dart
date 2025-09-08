class Asset {
  final int id;
  final String title;
  final String thumbnail;
  final String category;
  final String? downloads;
  final String? duration;
  final bool isNew;

  Asset({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.category,
    this.downloads,
    this.duration,
    this.isNew = false,
  });
}

class NewsItem {
  final int id;
  final String title;
  final String thumbnail;
  final String date;
  final String description;

  NewsItem({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.date,
    required this.description,
  });
}

class DownloadItem {
  final String id;
  final String title;
  final String thumbnail;
  final String format;
  final String quality;
  final String size;
  final DownloadStatus status;
  final int progress;
  final String eta;
  final String? error;

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

enum DownloadStatus { downloading, paused, completed, failed, queued }
