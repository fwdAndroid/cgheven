import 'package:cgheven/model/search_model.dart';
import 'package:cgheven/widget/search_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SearchResults extends StatelessWidget {
  final List<SearchItem> items;
  final String category;

  const SearchResults({super.key, required this.items, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
                '${items.length} ${category.toLowerCase()} found',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms)
              .slideX(begin: -0.2, end: 0, duration: 400.ms),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return SearchItemCard(item: items[index], index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
