class SearchItem {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imageUrl;
  final double rating;
  final double? price;
  final String? salary;
  final List<String> tags;

  SearchItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.rating,
    this.price,
    this.salary,
    this.tags = const [],
  });

  // Helper method to get the display price/salary
  String get displayPrice {
    if (salary != null) return salary!;
    if (price != null) return '\$${price!.toStringAsFixed(2)}';
    return 'Free';
  }

  // Helper method to check if item matches search query
  bool matchesQuery(String query) {
    if (query.isEmpty) return true;

    final lowerQuery = query.toLowerCase();
    return title.toLowerCase().contains(lowerQuery) ||
        description.toLowerCase().contains(lowerQuery) ||
        category.toLowerCase().contains(lowerQuery) ||
        tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
  }
}
