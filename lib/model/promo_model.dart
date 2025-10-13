class Promo {
  final int id;
  final String title;
  final String description;
  final String banner;

  Promo({
    required this.id,
    required this.title,
    required this.description,
    required this.banner,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    // Extract text from nested "description"
    final descList = json['description'] as List?;
    String descText = '';
    if (descList != null && descList.isNotEmpty) {
      final children = descList.first['children'] as List?;
      if (children != null && children.isNotEmpty) {
        descText = children.first['text'] ?? '';
      }
    }

    return Promo(
      id: json['id'],
      title: json['title'] ?? '',
      description: descText,
      banner: json['banner']?['banner'] ?? '',
    );
  }
}
