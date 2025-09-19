import 'package:cgheven/model/search_model.dart';
import 'package:cgheven/widget/animated_background.dart';
import 'package:cgheven/widget/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _selectedTabIndex = 0;

  final List<String> _categories = [
    'VFX',
    'Game Assets',
    '3D Models',
    'Lowpoly',
  ];

  // Sample data - in a real app, this would come from an API
  final List<SearchItem> _allItems = [
    SearchItem(
      id: '1',
      title: 'Epic Fire VFX Pack',
      category: 'VFX',
      description: 'High-quality fire effects for your projects',
      imageUrl:
          'https://images.pexels.com/photos/1105766/pexels-photo-1105766.jpeg',
      rating: 4.8,
      price: 29.99,
    ),
    SearchItem(
      id: '2',
      title: 'Senior 3D Artist Position',
      category: 'Game Assets',
      description: 'Remote position at leading game studio',
      imageUrl:
          'https://images.pexels.com/photos/7988079/pexels-photo-7988079.jpeg',
      rating: 4.5,
      salary: '\$85,000',
    ),
    SearchItem(
      id: '3',
      title: 'Low Poly Character Pack',
      category: 'Lowpoly',
      description: 'Stylized characters for mobile games',
      imageUrl:
          'https://images.pexels.com/photos/8088467/pexels-photo-8088467.jpeg',
      rating: 4.7,
      price: 15.99,
    ),
    SearchItem(
      id: '4',
      title: 'Realistic Car Model',
      category: '3D Models',
      description: 'High-detail automotive model',
      imageUrl:
          'https://images.pexels.com/photos/3802510/pexels-photo-3802510.jpeg',
      rating: 4.9,
      price: 45.00,
    ),
    SearchItem(
      id: '5',
      title: 'Magic Spell Effects',
      category: 'VFX',
      description: 'Fantasy spell animations and particles',
      imageUrl:
          'https://images.pexels.com/photos/796206/pexels-photo-796206.jpeg',
      rating: 4.6,
      price: 35.00,
    ),
    SearchItem(
      id: '6',
      title: 'VFX Compositor Remote',
      category: 'Game Assets',
      description: 'Work on blockbuster films from home',
      imageUrl:
          'https://images.pexels.com/photos/7688336/pexels-photo-7688336.jpeg',
      rating: 4.3,
      salary: '\$75,000',
    ),
  ];

  List<SearchItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _filteredItems = _allItems;
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _selectedTabIndex = _tabController.index;
        _filterItems();
      });
    }
  }

  void _filterItems() {
    String selectedCategory = _categories[_selectedTabIndex];
    setState(() {
      _filteredItems = _allItems.where((item) {
        bool matchesCategory = item.category == selectedCategory;
        bool matchesSearch =
            _searchQuery.isEmpty ||
            item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.description.toLowerCase().contains(_searchQuery.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filterItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Search', style: GoogleFonts.poppins(color: Colors.white)),
        centerTitle: true,
      ),
      body: AnimatedBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildTabBar(),
              const SizedBox(height: 20),
              Expanded(child: _buildSearchResults()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F2937).withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF374151), width: 1),
        ),
        child: TextField(
          style: GoogleFonts.poppins(color: Colors.white),
          controller: _searchController,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Search effects, explosions, magic...',
            hintStyle: GoogleFonts.poppins(color: Color(0xFF9CA3AF)),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          // decoration: InputDecoration(
          //   hintText:
          //       'Search ${_categories[_selectedTabIndex].toLowerCase()}...',
          //   prefixIcon: const Icon(Icons.search, color: Colors.white),
          //   suffixIcon: _searchQuery.isNotEmpty
          //       ? IconButton(
          //           icon: const Icon(Icons.clear, color: Colors.grey),
          //           onPressed: () {
          //             _searchController.clear();
          //             _onSearchChanged('');
          //           },
          //         )
          //       : null,
          //   border: InputBorder.none,
          //   contentPadding: const EdgeInsets.symmetric(
          //     horizontal: 20,
          //     vertical: 15,
          //   ),
          // ),
        ),
      ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.5, end: 0, duration: 600.ms),
    );
  }

  Widget _buildTabBar() {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity, // make it full width
              child: TabBar(
                indicatorSize:
                    TabBarIndicatorSize.tab, // 👈 force full tab width

                controller: _tabController,
                isScrollable: true, // 👈 equal width tabs
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF14B8A6), Color(0xFFF97316)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.7),
                labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                tabs: _categories
                    .map((category) => Tab(text: category))
                    .toList(),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: 200.ms)
        .slideY(begin: -0.3, end: 0, duration: 800.ms);
  }

  Widget _buildSearchResults() {
    if (_filteredItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty
                  ? 'No ${_categories[_selectedTabIndex].toLowerCase()} available'
                  : 'No results found for "$_searchQuery"',
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.7),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return SearchResults(
      items: _filteredItems,
      category: _categories[_selectedTabIndex],
    );
  }
}
