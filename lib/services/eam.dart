import 'package:cgheven/services/api_services.dart';
import 'package:flutter/material.dart';

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

class VfxCategoriesPage extends StatefulWidget {
  const VfxCategoriesPage({super.key});

  @override
  State<VfxCategoriesPage> createState() => _VfxCategoriesPageState();
}

class _VfxCategoriesPageState extends State<VfxCategoriesPage> {
  late Future<List<Category>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = AssetApiService().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VFX Subcategories"),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<Category>>(
        future: _futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('snapshot error: ${snapshot.error}');
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No subcategories found for VFX"));
          } else {
            final vfxCategories = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: vfxCategories
                    .map(
                      (cat) => Chip(
                        label: Text(cat.name),
                        backgroundColor: Colors.purple.shade100,
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
