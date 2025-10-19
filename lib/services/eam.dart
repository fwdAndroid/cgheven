class Category {
  final String name;
  final ParentCategory? parentCategory;

  Category({required this.name, this.parentCategory});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['Name'] ?? '',
      parentCategory: json['parent_category'] != null
          ? ParentCategory.fromJson(json['parent_category'])
          : null,
    );
  }
}

class ParentCategory {
  final String name;

  ParentCategory({required this.name});

  factory ParentCategory.fromJson(Map<String, dynamic> json) {
    return ParentCategory(name: json['Name'] ?? '');
  }
}
