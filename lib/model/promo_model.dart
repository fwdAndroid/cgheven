// lib/model/promo_model.dart
class PromoModel {
  final int id;
  final String title;
  final String description;
  final String bannerUrl;
  final String? youtubeEmbedUrl;
  final bool active;

  PromoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.bannerUrl,
    this.youtubeEmbedUrl,
    required this.active,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    final banner = json['banner'] ?? {};
    final descList = json['description'] as List<dynamic>? ?? [];
    String descText = '';

    if (descList.isNotEmpty) {
      final children = descList[0]['children'] as List<dynamic>?;
      if (children != null && children.isNotEmpty) {
        descText = children[0]['text'] ?? '';
      }
    }

    return PromoModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: descText,
      bannerUrl: banner['url'] ?? '',
      youtubeEmbedUrl: banner['embed_url'],
      active: json['active'] ?? false,
    );
  }
}
