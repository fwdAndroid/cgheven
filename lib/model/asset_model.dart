class AssetModel {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final DateTime publishedAt;
  final List<String> files;
  final String previews;
  final bool isPatreonLocked;
  final String? category; // Optional (you can fill later)
  final String? slug;
  final List<String> tags; // ✅ List<String>

  AssetModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.publishedAt,
    required this.files,
    required this.previews,
    required this.isPatreonLocked,
    required this.tags,
    this.category,
    this.slug,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'] ?? 0,
      title: json['Title'] ?? '',
      description: (json['Description'] is List && json['Description'].isEmpty)
          ? ''
          : json['Description'].toString(),
      thumbnail: json['thumbnail'] ?? '',
      publishedAt:
          DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      tags:
          (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString().toLowerCase()) // ✅ convert to lowercase
              .toList() ??
          [],
      previews: json['previews'] ?? '',
      isPatreonLocked: json['is_patreon_locked'] ?? false,
      category: null, // Not in JSON (add later if needed)
      slug: json['assets_slug'],
    );
  }
}
