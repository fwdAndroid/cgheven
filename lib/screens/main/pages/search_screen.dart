import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cgheven/provider/search_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  void _onSearch() {
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      context.read<SearchProvider>().search(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Assets', style: GoogleFonts.poppins()),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onSubmitted: (_) => _onSearch(),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search by title...',
                hintStyle: const TextStyle(color: Colors.white54),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _onSearch,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (provider.isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            else if (provider.error != null)
              Text(
                'Error: ${provider.error}',
                style: const TextStyle(color: Colors.red),
              )
            else if (provider.results.isEmpty)
              const Text(
                'No results found',
                style: TextStyle(color: Colors.white70),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: provider.results.length,
                  itemBuilder: (context, index) {
                    final asset = provider.results[index];
                    return Card(
                      color: Colors.white10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(
                          asset.title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Category: ${asset.categorie}\nSubcategories: ${asset.subcategories.map((s) => s.name).join(', ')}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
