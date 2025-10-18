class Promo {
  final int id;
  final String documentId;
  final String title;
  final String description;
  final List<String> banners;
  final String startDate;
  final String endDate;
  final bool active;

  Promo({
    required this.id,
    required this.documentId,
    required this.title,
    required this.description,
    required this.banners,
    required this.startDate,
    required this.endDate,
    required this.active,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    // ✅ Handle description text extraction
    String extractDescription(dynamic desc) {
      if (desc is List && desc.isNotEmpty) {
        final children = desc[0]?['children'];
        if (children is List && children.isNotEmpty) {
          return children[0]?['text'] ?? '';
        }
      }
      return '';
    }

    // ✅ Handle banner being String or List
    List<String> parseBanners(dynamic banner) {
      if (banner == null) return [];
      if (banner is String) return [banner];
      if (banner is List) {
        return banner.map((b) => b.toString()).toList();
      }
      if (banner is Map && banner.containsKey('banner')) {
        return [banner['banner'].toString()];
      }
      return [];
    }

    return Promo(
      id: json['id'] ?? 0,
      documentId: json['documentId'] ?? '',
      title: json['title'] ?? '',
      description: extractDescription(json['description']),
      banners: parseBanners(json['banner']),
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      active: json['active'] ?? false,
    );
  }
}
