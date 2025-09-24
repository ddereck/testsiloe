import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String imagePath;
  final IconData icon;
  final VoidCallback onTap;

  MenuItem({
    required this.title,
    required this.imagePath,
    required this.icon,
    required this.onTap,
  });
}
