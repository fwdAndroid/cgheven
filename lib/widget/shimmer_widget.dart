import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerGrid() {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.white10,
        highlightColor: Colors.white24,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF00bcd4).withOpacity(.2),
              width: 0.5,
            ),
          ),
        ),
      ),
    ),
  );
}
