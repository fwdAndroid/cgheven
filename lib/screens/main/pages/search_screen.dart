import 'dart:async';
import 'package:cgheven/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cgheven/provider/search_provider.dart';
import 'package:cgheven/model/asset_model.dart';
import 'package:cgheven/widget/asset_card.dart';
import 'package:cgheven/screens/detail/assets_detail_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    // 🔍 Add listener for auto search
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final query = _controller.text.trim();

    // Cancel the previous timer if user keeps typing
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Wait 400ms after typing stops
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.isNotEmpty) {
        context.read<SearchProvider>().search(query);
      } else {
        context.read<SearchProvider>().clearResults();
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF0B1C24),
        title: Text(
          'Search Assets',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0B1C24), Color(0xFF1A0F0D)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.darkBackground.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF00bcd4).withOpacity(.4),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search by title...',
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 🌀 LOADING / ERROR / RESULTS
              if (provider.isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                )
              else if (provider.error != null)
                Expanded(
                  child: Center(
                    child: Text(
                      'Error: ${provider.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else if (provider.results.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                )
              else
                Expanded(child: _buildGrid(provider.results)),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Grid Builder Using AssetCard
  Widget _buildGrid(List<AssetModel> assets) {
    final screenWidth = MediaQuery.of(context).size.width;
    const crossAxisCount = 2;
    const spacing = 16.0;
    final totalSpacing = spacing * (crossAxisCount + 1);
    final cardWidth = (screenWidth - totalSpacing - 24) / crossAxisCount;
    final cardHeight = cardWidth * 0.9;
    final aspectRatio = cardWidth / cardHeight;

    return GridView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      itemCount: assets.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (context, index) {
        final asset = assets[index];
        return AssetCard(
          asset: asset,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => AssetDetailScreen(asset: asset),
              ),
            );
          },
        );
      },
    );
  }
}
