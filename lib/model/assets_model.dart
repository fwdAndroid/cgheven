class Asset {
  final int id;
  final String title;
  final String category;
  final String thumbnail;
  final DateTime publishedAt;
  final String description;
  bool isFavorite; // local state
  final List<String> subCategories; // ✅ Add this
  final List<String> files; // ✅ new field for multiple .mp4 URLs

  Asset({
    required this.id,
    required this.title,
    required this.category,
    required this.thumbnail,
    required this.description,
    required this.publishedAt,
    this.isFavorite = false,
    this.subCategories = const [],
    this.files = const [],
  });

  bool get isNew {
    final now = DateTime.now().toUtc();
    return now.difference(publishedAt).inHours < 24;
  }

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? "",
      category: json['category'] ?? '',
      thumbnail:
          (json['thumbnail'] != null && (json['thumbnail'] as List).isNotEmpty)
          ? json['thumbnail'][0]
          : 'https://via.placeholder.com/300x200.png?text=No+Image',
      publishedAt: DateTime.parse(
        json['attributes'] ?? DateTime.now().toIso8601String(),
      ),
      subCategories:
          (json['sub_categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [], // ✅ safely parse list
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [], // ✅ parse multiple .mp4 URLs
    );
  }
}
