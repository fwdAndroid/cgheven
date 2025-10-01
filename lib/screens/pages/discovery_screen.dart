import 'package:cgheven/model/category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topLeft, // 135 degrees = top-left → bottom-right
      //       end: Alignment.bottomRight,
      //       colors: [
      //         Color(0xFF0B1C24), // #0b1c24 at 0%
      //         Color(0xFF1A0F0D), // #1a0f0d at 100%
      //       ],
      //     ),
      //   ),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      //     child: isGridView
      //         ? GridView.builder(
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 1,
      //               childAspectRatio: 3,
      //               mainAxisSpacing: 16,
      //             ),
      //             itemCount: categories.length,
      //             itemBuilder: (context, index) {
      //               final category = categories[index];
      //               return CategoryCard(category: category);
      //             },
      //           )
      //         : ListView.builder(
      //             itemCount: categories.length,
      //             itemBuilder: (context, index) {
      //               final category = categories[index];
      //               return Padding(
      //                 padding: const EdgeInsets.only(bottom: 16),
      //                 child: CategoryCard(category: category),
      //               );
      //             },
      //           ),
      //   ),
      // ),
    );
  }
}

// class CategoryCard extends StatelessWidget {
//   final VFXCategory category;
//   const CategoryCard({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(24),
//             color: Colors.grey.shade900.withOpacity(0.3),
//             border: Border.all(
//               color: const Color(0xFF00bcd4).withOpacity(.4),
//               width: 1,
//             ),
//             boxShadow: [BoxShadow(color: category.bgGlow, blurRadius: 30)],
//           ),
//           child: Row(
//             children: [
//               // Icon with glow
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     color: Colors.white.withOpacity(0.1),
//                     boxShadow: [
//                       BoxShadow(color: category.glowColor, blurRadius: 20),
//                     ],
//                   ),
//                   child: Icon(category.icon, color: Colors.white, size: 32),
//                 ),
//               ),
//               // Thumbnail
//               // Container(
//               //   width: 80,
//               //   height: 80,
//               //   margin: const EdgeInsets.only(right: 16),
//               //   decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.circular(16),
//               //     image: DecorationImage(
//               //       image: NetworkImage(category.thumbnail),
//               //       fit: BoxFit.cover,
//               //     ),
//               //   ),
//               // ),
//               // Content
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Text(
//                         category.name,
//                         style: GoogleFonts.poppins(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       category.description,
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.withOpacity(0.5),
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.grey.shade700),
//                         ),
//                         child: Text(
//                           category.assetCount,
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                   ],
//                 ),
//               ),
//               // Play Button
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withOpacity(0.2),
//                     border: Border.all(color: Colors.white30),
//                   ),
//                   child: const Icon(Icons.play_arrow, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
