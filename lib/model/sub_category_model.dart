class SubcategoryModel {
  final int id;
  final String name;
  final String slug;

  SubcategoryModel({required this.id, required this.name, required this.slug});

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['id'] ?? 0,
      name: json['Name'] ?? '',
      slug: json['Slug'] ?? '',
    );
  }
}
