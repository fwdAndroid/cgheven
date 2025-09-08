import 'package:flutter/material.dart';

class VFXCategory {
  final int id;
  final String name;
  final IconData icon;
  final String description;
  final String thumbnail;
  final String assetCount;
  final Gradient gradient;
  final Color glowColor;
  final Color bgGlow;

  VFXCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.thumbnail,
    required this.assetCount,
    required this.gradient,
    required this.glowColor,
    required this.bgGlow,
  });
}
