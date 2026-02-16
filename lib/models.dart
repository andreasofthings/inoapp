import 'package:flutter/material.dart';

class MethodItem {
  final String title;
  final String duration;
  final IconData icon;
  final Color accentColor;
  final bool isFavorite;

  const MethodItem({
    required this.title,
    required this.duration,
    required this.icon,
    required this.accentColor,
    this.isFavorite = false,
  });
}
