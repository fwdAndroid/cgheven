class AssetModel {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final DateTime publishedAt;
  final List<String> files;
  final String previews;
  final bool isPatreonLocked;
  final String categorie;
  final String? slug;
  final List<String> tags;

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
    required this.categorie,
    this.slug,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    final categorie = json['categorie']; // ✅ Extract category first

    return AssetModel(
      id: json['id'] ?? 0,
      title: json['Title'] ?? '',
      description:
          (json['Description'] != null && json['Description'].isNotEmpty)
          ? json['Description'].toString()
          : '',
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
              ?.map((e) => e.toString().toLowerCase())
              .toList() ??
          [],
      categorie: categorie != null ? categorie['Name'] ?? '' : '', // ✅ Correct
      previews: json['previews'] ?? '',
      isPatreonLocked: json['is_patreon_locked'] ?? false,
      slug: json['assets_slug'],
    );
  }
}
