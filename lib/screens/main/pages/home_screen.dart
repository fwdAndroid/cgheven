import 'package:cgheven/utils/app_theme.dart';
import 'package:cgheven/widget/search_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeAssetSection = 'New\n Assets';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0B1C24), Color(0xFF1A0F0D)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),

              /// 🔎 Search + Download button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: buildSearchBox(context)),
                    IconButton(
                      icon: const Icon(
                        Icons.download,
                        color: Color(0xFF9CA3AF),
                        size: 32,
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const DownloadScreen(),
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
              ),

              /// 🔹 Sections (New, Trending, News)
              _buildSections(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSections() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: AppTheme.darkBackground.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF00bcd4).withOpacity(.3),
            width: 1,
          ),
        ),
        child: Row(
          children: ['New\n Assets', 'Trending\n Assets', 'News'].map((
            section,
          ) {
            final isActive = activeAssetSection == section;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    activeAssetSection = section;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: isActive ? AppTheme.fireGradient : null,
                    color: isActive ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      section,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
